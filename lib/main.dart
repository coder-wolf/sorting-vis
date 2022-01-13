import 'package:flutter/material.dart';
import 'dart:math';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Startpoint(),
    );
  }
}

class Startpoint extends StatefulWidget {
  Startpoint({
    Key? key,
  }) : super(key: key);

  @override
  State<Startpoint> createState() => _StartpointState();
}

class _StartpointState extends State<Startpoint> {
  @override
  void initState() {
    var random = new Random();
    for (int i = 0; i < 10; i++) {
      initArr.add(random.nextInt(100));
    } // initializing the array with random numbers. We will run simulation on this later.
    super.initState();
  }
  // later take this input from user

  var initArr = []; //[41, 32, 43, 23, 54, 65, 76, 87, 98, 19];
  var arr = []; //[41, 32, 43, 23, 54, 65, 76, 87, 98, 19];
  var iPointer = 0, jPointer = 0;

  // DOC this is the bubble sort algorithm
  void bubbleSort() async {
    for (int i = 0; i < initArr.length; i++) {
      arr[i] = initArr[i];
    }
    for (int i = 0; i < arr.length; i++) {
      for (int j = i; j < arr.length; j++) {
        // await Future.delayed(const Duration(seconds: 1), () {});
        if (arr[i] > arr[j]) {
          setState(() {
            var temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            jPointer = j;
            // iPointer = i;
          });
          await Future.delayed(const Duration(milliseconds: 800), () {});
        } else {
          setState(() {
            jPointer = j;
          });
          await Future.delayed(const Duration(milliseconds: 800), () {});
        }
      }
      setState(() {
        iPointer = i + 1;
      });
      // await Future.delayed(const Duration(seconds: 1), () {});
    }
  }
  // note bubble sort ends here

  @override
  Widget build(BuildContext context) {
    if (arr.isEmpty)
      for (int i = 0; i < initArr.length; i++) {
        arr.add(initArr[i]);
      }

    w = MediaQuery.of(context).size.width * (1 / 1000);
    // bubbleSort(arrToSort);
    return Scaffold(
      body: Container(
        // height: double.infinity,
        // width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      "Bubble Sort",
                      style: TextStyle(
                        fontSize: w * 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(w * 40),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            iPointer = 0;
                            jPointer = 0;
                          });
                          bubbleSort();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w * 13),
                              color: Colors.green,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.2),
                                  spreadRadius: w * 3,
                                  blurRadius: w * 10,
                                ),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.all(w * 8),
                            child: Center(
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(w * 10),
                  child: Row(
                      children: List<Widget>.generate(arr.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(w * 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10 * w),
                          child: Text(
                            arr[index].toString(),
                            style: TextStyle(
                              fontSize: w * 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Padding(
                  padding: EdgeInsets.only(right: 55 * w, bottom: 20 * w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(arr.length, (index) {
                      return Column(
                        children: [
                          // Spacer(),
                          IndividualData(
                            height: arr[index],
                            sorted: index < iPointer,
                            isPointed: index == iPointer || index == jPointer,
                            isDone: iPointer == arr.length,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IndividualData extends StatelessWidget {
  IndividualData({
    Key? key,
    this.height,
    this.isPointed,
    this.sorted,
    this.isDone,
  }) : super(key: key);
  var height;
  var isPointed;
  var sorted;
  var isDone;

  @override
  Widget build(BuildContext context) {
    print("$height ${w * 30}");
    return Column(
      children: [
        isPointed
            ? isDone
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 300),
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(w * 8.0),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Icon(Icons.arrow_circle_down_rounded,
                    color: isDone ? Colors.green : Colors.amber[800],
                    size: w * 50)
            : Container(),
        Text(height.toString()),
        SizedBox(
          height: w * 10,
        ),
        Padding(
          padding: EdgeInsets.all(w * 10),
          child: Container(
            decoration: BoxDecoration(
              color: sorted ? Colors.blue : Colors.red,
              borderRadius: BorderRadius.circular(w * 5),
            ),
            width: w * 30,
            height:
                (height + 1) * MediaQuery.of(context).size.height * (5 / 1000),
          ),
        ),
      ],
    );
  }
}
