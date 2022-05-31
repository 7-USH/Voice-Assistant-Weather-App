// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset(
          imagePath(id: id),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " " + todayTime() + ":00",
              style: numText(
                  color: Colors.white, size: 20, weight: FontWeight.normal),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  celsiusCalc(temp).toString() + "°",
                  style: GoogleFonts.acme(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      shadows: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0.4, 2),
                            spreadRadius: 1,
                            blurRadius: 8)
                      ]),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
