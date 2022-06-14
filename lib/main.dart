// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weather_app/screens/error_page.dart';
import 'package:weather_app/screens/loading_screen.dart';

void main() {
  Paint.enableDithering = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

