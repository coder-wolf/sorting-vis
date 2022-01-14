import 'package:flutter/material.dart';
import 'screens/sorting_sim_page/sorting_sim.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SortingSim(),
    );
  }
}
