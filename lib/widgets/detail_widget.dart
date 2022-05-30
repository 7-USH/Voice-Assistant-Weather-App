// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/weather_image.dart';

class TodaysDetail extends StatelessWidget {
  TodaysDetail(
      {Key? key, required this.temp, required this.id, required this.time})
      : super(key: key);
  String image = "assets/weather/Zaps.png";
  int temp;
  int id;
  String time;

  String todayTime() {
    return DateTime.parse(time).hour.toString();
  }

  int celsiusCalc(int kelvin) {
    return kelvin - 273;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 15, top: 10),
      decoration: BoxDecoration(
          color: blobColor,
          gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [
                Colors.white12,
                Colors.white12.withOpacity(0.5),
              ]),
          borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Image.asset(
          imagePath(id: id),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todayTime() + ":00       ",
              style: numText(
                  color: Colors.white, size: 20, weight: FontWeight.normal),
            ),
            Text(
              celsiusCalc(temp).toString() + "°",
              style: numText(
                  color: Colors.white, size: 40, weight: FontWeight.normal),
            ),
          ],
        )
      ]),
    );
  }
}
