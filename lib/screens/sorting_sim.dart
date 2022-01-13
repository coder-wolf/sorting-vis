import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/size.dart';

class SortingSim extends StatefulWidget {
  SortingSim({
    Key? key,
  }) : super(key: key);

  @override
  State<SortingSim> createState() => _SortingSimState();
}

class _SortingSimState extends State<SortingSim> {
  var initArr =
      []; // this array will remain unchanged throughout the simulation.
  var arr = []; // this array will be changed throughout the simulation.
  var iPointer = 0, jPointer = 0;

  @override
  void initState() {
    var random = new Random();
    for (int i = 0; i < 10; i++) {
      initArr.add(random.nextInt(100));
    } // initializing the array with random numbers. We will run simulation on this later.
    super.initState();
  }

  void bubbleSort() async {
    for (int i = 0; i < initArr.length; i++) {
      arr[i] = initArr[i];
    }
    for (int i = 0; i < arr.length; i++) {
      for (int j = i; j < arr.length; j++) {
        if (arr[i] > arr[j]) {
          setState(() {
            var temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            jPointer = j;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    if (arr.isEmpty)
      for (int i = 0; i < initArr.length; i++) {
        arr.add(initArr[i]);
      }

    w = MediaQuery.of(context).size.width * (1 / 1000);
    // bubbleSort(arrToSort);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: w * 20, top: 20 * w),
        child: Container(
          // height: double.infinity,
          // width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // NOTE here we're printing the array
                  Padding(
                    padding: EdgeInsets.all(w * 10),
                    child: Row(
                        children: List<Widget>.generate(arr.length, (index) {
                      return Padding(
                        padding: EdgeInsets.all(w * 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.3),
                            //     blurRadius: 3 * w,
                            //     spreadRadius: w * 3,
                            //   ),
                            // ],
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        var temp = Random().nextInt(100);
                        initArr.add(temp);
                        arr.add(temp);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 15),
                        border: Border.all(
                          color: Colors.indigo,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10 * w),
                        child: Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(w * 7),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              initArr = [];
                              arr = [];
                              iPointer = 0;
                              jPointer = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w * 13),
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.2),
                                    spreadRadius: w * 3,
                                    blurRadius: w * 10,
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(w * 8),
                              child: const Center(
                                child: Icon(
                                  Icons.restart_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(w * 7),
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
                  SizedBox(
                    width: w * 30,
                  ),
                ],
              ),
              // NOTE visualization part of array -- code starts from here.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 55 * w, bottom: 25 * w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        arr.length,
                        (index) {
                          return IndividualData(
                            height: arr[index],
                            sorted: index < iPointer,
                            isPointed: index == iPointer || index == jPointer,
                            isDone: iPointer == arr.length,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
              color: sorted ? Colors.green[400] : Colors.indigo[400],
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
