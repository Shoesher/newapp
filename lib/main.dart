import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/greetings.dart';
import 'pages/numbers.dart';
import 'pages/commonphrases.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Homepage()
    );
  }
}
