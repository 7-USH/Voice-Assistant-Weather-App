// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/screens/voice.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bgColor,
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(
              color: darkBgColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.mapLocationDot,
                      color: Colors.white,
                      size: 30,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const VoicePage();
                    }));
                  },
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: blobColor,
                          gradient: LinearGradient(
                              colors: [blobColor, blobColor.withOpacity(0.6)])),
                      child: const Icon(
                        FontAwesomeIcons.microphoneLines,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.bars,
                      color: Colors.white,
                      size: 30,
                    ))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Column(
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
                          color: Colors.white,
                          size: size.height/25,
                          weight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height/35,
              ),
              Center(
                  child: Image.asset(
                "assets/sun.png",
                scale: size.height/1200,
              )),
              const SizedBox(
                height: 20,
              ),
              Text(
                "  29°",
                textAlign: TextAlign.left,
                style: numText(
                    color: textColor, size: size.height/8, weight: FontWeight.bold),
              ),
              Text(
                "Cloudy",
                style: appText(
                    color: textColor, size: size.height/35, weight: FontWeight.w600),
              ),
            ],
          ),
        ));
  }
}
