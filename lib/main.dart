
import 'package:flutter/material.dart';
import 'package:spleshopnginglist26/loginpage.dart';
import 'package:spleshopnginglist26/spleash1.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Spleash_1(),
    );
  }
}
