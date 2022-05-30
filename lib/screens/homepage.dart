// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/models/weather_image.dart';
import 'package:weather_app/screens/detailweather.dart';
import 'package:weather_app/screens/map_screen.dart';
import 'package:weather_app/screens/voice.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.model,required this.coords}) : super(key: key);
  WeatherModel model;
  List<double> coords;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cityName = "";
  int temperature = 0;
  String message = "Good day";
  String date = "03-Mar-2022";
  Map image = {"assets/weather/Zaps.png": 3};

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() {
    setState(() {
      cityName = widget.model.name ?? "Globe";
      temperature = celsiusCalc(widget.model.main!.temp!.toInt());
      image = homeImagePath(id: widget.model.weather!.id!.toInt());
      message = widget.model.weather!.description!;
      DateTime today = DateTime.now();
      DateFormat formatter = DateFormat("d-MMMM-yyyy");
      date = formatter.format(today);
    });
  }

  int celsiusCalc(int kelvin) {
    return kelvin - 273;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: darkColor.withOpacity(0.98),
        bottomNavigationBar: Container(
          height: size.height / 9,
          decoration: BoxDecoration(
              color: darkBgColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return MapScreen(coords: widget.coords,);
                      }));
                    },
                    icon: const Icon(
                      FontAwesomeIcons.mapLocationDot,
                      color: Colors.white,
                      size: 30,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return VoicePage(
                        model: widget.model,
                      );
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
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ForeCastDetails(model: widget.model);
                      }));
                    },
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
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                  0.1,
                  0.9
                ],
                    colors: [
                  darkColor,
                  bgColor,
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                FittedBox(
                  child: Column(
                    children: [
                      Text(
                        date,
                        style: appText(
                            color: textColor,
                            size: 15,
                            weight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        cityName,
                        style: appText(
                            color: Colors.white,
                            size: size.height / 25,
                            weight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Center(
                    child: Image.asset(
                  image.keys.elementAt(0),
                  scale: image.values.elementAt(0),
                )),
                Text(
                  "  $temperature°",
                  textAlign: TextAlign.left,
                  style: numText(
                      color: textColor,
                      size: size.height / 8,
                      weight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    message,
                    style: appText(
                        color: textColor,
                        size: size.height / 35,
                        weight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
