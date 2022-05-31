// ignore_for_file: prefer_const_constructors, duplicate_ignore, must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/weather_image.dart';

class NextDetails extends StatelessWidget {
  NextDetails(
      {Key? key, required this.date, required this.id, required this.temp})
      : super(key: key);
  String image = "assets/weather/Zaps.png";
  int id;
  String date;
  int temp;

  String day() {
    int todayDay = DateTime.parse(date).weekday;
    if (todayDay == 1) {
      return "Monday";
    }
    if (todayDay == 2) {
      return "Tuesday";
    }
    if (todayDay == 3) {
      return "Wednesday";
    }
    if (todayDay == 4) {
      return "Thursday";
    }
    if (todayDay == 5) {
      return "Friday";
    }
    if (todayDay == 6) {
      return "Saturday";
    }
    return "Sunday";
  }

  String dayDate() {
    DateTime weekdates = DateTime.parse(date);
    DateFormat formatter = DateFormat("MMMM, d");
    return formatter.format(weekdates);
  }

  int celsiusCalc(int kelvin) {
    return kelvin - 273;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
           Column(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(day(),
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: kButtonShadows)),
                ),
                Text(
                  dayDate(),
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    shadows: kButtonShadows),
                )
              ],
                   ),
                   Spacer(),
          Text(
            celsiusCalc(temp).toString()+"°",
            style: GoogleFonts.acme(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.normal,
                shadows: kButtonShadows),
          ),
          Image.asset(
            imagePath(id: id),
            scale: 7,
          ),
        ],
      ),
    );
  }
}
