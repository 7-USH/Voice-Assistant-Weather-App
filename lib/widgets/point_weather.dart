// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/weather_image.dart';
import 'dart:math' as math;

class PointWeather extends StatefulWidget {
  PointWeather(
      {Key? key, required this.id, required this.name, required this.temp})
      : super(key: key);
  String name;
  int temp;
  int id;

  @override
  State<PointWeather> createState() => _PointWeatherState();
}

class _PointWeatherState extends State<PointWeather>
    with SingleTickerProviderStateMixin {
  String image = "assets/weather/Zaps.png";
  late Animation<double> _animation;
  late AnimationController _controller;

  int celsiusCalc(int kelvin) {
    return kelvin - 273;
  }

  void setRotation(int deg) {
    final angle = deg * math.pi / 180;
    _animation = Tween<double>(begin: 0, end: angle).animate(_controller);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    setRotation(-90);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: blobColor,
          gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [
                bgColor,
                darkBgColor,
              ]),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: appText(
                      color: Colors.white, size: 30, weight: FontWeight.normal),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) =>
                      Transform.rotate(angle: _animation.value, child: child),
                  child: Icon(
                    Icons.swipe_down_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath(id: widget.id),
                scale: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Today, ",
                    style: botFont(
                        color: Colors.white,
                        size: 25,
                        weight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${celsiusCalc(widget.temp)}°",
                    style: botFont(
                        color: Colors.white, size: 60, weight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
