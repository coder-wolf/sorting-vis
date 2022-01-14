import 'package:flutter/material.dart';
import 'package:sorting_vis/constants/size.dart';

class Bar extends StatelessWidget {
  Bar({
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
