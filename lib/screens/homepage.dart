// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "03-Mar-2022",
                style: appText(
                    color: textColor, size: 15, weight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Panjim, Goa",
                style: appText(
                    color: Colors.white, size: 35, weight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: Image.asset(
                "assets/sun-clouds-rain.png",
                scale: 0.7,
              )),
              const SizedBox(
                height: 20,
              ),
              Text(
                "  29°",
                textAlign: TextAlign.left,
                style: numText(
                    color: textColor, size: 80, weight: FontWeight.bold),
              ),
              Text(
                "Cloudy",
                style: appText(
                    color: textColor, size: 20, weight: FontWeight.w600),
              )
            ],
          ),
        ));
  }
}
