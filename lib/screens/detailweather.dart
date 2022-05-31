// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/weather_image.dart';
import 'package:weather_app/widgets/detail_widget.dart';
import 'package:weather_app/models/moredetails.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/widgets/nextdetail_widget.dart';

class ForeCastDetails extends StatefulWidget {
  ForeCastDetails({Key? key, required this.model}) : super(key: key);
  WeatherModel model;
  @override
  State<ForeCastDetails> createState() => _ForeCastDetailsState();
}

class _ForeCastDetailsState extends State<ForeCastDetails> {
  WeatherDetails weatherDetails = WeatherDetails();
  List<MoreDetails> models = [];
  List<MoreDetails> today = [];
  List<MoreDetails> week = [];
  late bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    getMoreDetails().then((value) {
      String d = todayDate();
      for (int i = 0; i < value.length; i++) {
        models.add(MoreDetails.fromJson(value[i]));
        if (dateParser(models[i].dtTxt!) == d) {
          today.add(models[i]);
          setState(() {});
        }
      }
      getWeekInfo();
      _isLoading = false;
      setState(() {
        
      });
    });
    super.initState();
  }

  void getWeekInfo() {
    int d = DateTime.now().day;
    for (int i = 0; i < models.length; i++) {
      print(d);
      if (d > 31) {
        d = 1;
      }
      if (int.parse(dateParser(models[i].dtTxt!)) == d) {
        week.add(models[i]);
        d++;
      }
    }
    setState(() {});
  }

  String dateParser(String date) {
    return DateTime.parse(date).day.toString();
  }

  String todayDate() {
    DateTime today = DateTime.now();
    return today.day.toString();
  }

  String mainDate() {
    DateTime today = DateTime.now();
    DateFormat formatter = DateFormat("MMMM d, yyyy");
    return formatter.format(today);
  }

  Future<List> getMoreDetails() async {
    var details = await weatherDetails.getNextData(widget.model.name!);
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor.withOpacity(0.98),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Forecast report",
          style:
              appText(color: Colors.white, size: 25, weight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: const [
                0.1,
                0.9
              ],
                  colors: [
                darkColor,
                bgColor,
              ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Today",
                      style: appText(
                          color: Colors.white,
                          size: 20,
                          weight: FontWeight.normal),
                    ),
                    Text(mainDate(),
                        style: appText(
                            color: Colors.grey,
                            size: 15,
                            weight: FontWeight.normal))
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: !_isLoading
                        ? ListView.builder(
                            itemCount: today.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return TodaysDetail(
                                  temp: today[index].main!.temp!.toInt(),
                                  id: today[index].weather![0].id!.toInt(),
                                  time: today[index].dtTxt.toString());
                            }))
                        : ListView.builder(
                            itemCount: 7,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.white12,
                                child: Container(
                                  width: 200,
                                  padding: const EdgeInsets.all(8),
                                  margin:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                          end: Alignment.bottomRight,
                                          begin: Alignment.topLeft,
                                          colors: [
                                            Colors.white12,
                                            Colors.white12.withOpacity(0.5),
                                          ]),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          imagePath(id: 301),
                                          color: Colors.transparent,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              " " + "         ",
                                              style: numText(
                                                  color: Colors.white,
                                                  size: 20,
                                                  weight: FontWeight.normal),
                                            ),
                                            Expanded(
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text(
                                                  " ",
                                                  style: GoogleFonts.acme(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      shadows: kButtonShadows),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              );
                            })),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Next forecast",
                      style: appText(
                          color: Colors.white,
                          size: 23,
                          weight: FontWeight.normal),
                    ),
                    Icon(
                      FontAwesomeIcons.calendar,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: !_isLoading
                        ? ListView.builder(
                            itemCount: week.length,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return NextDetails(
                                  date: week[index].dtTxt.toString(),
                                  id: week[index].weather![0].id!.toInt(),
                                  temp: week[index].main!.temp!.toInt());
                            }))
                        : ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.white12,
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                        end: Alignment.bottomRight,
                                        begin: Alignment.topLeft,
                                        colors: [
                                          Colors.white12,
                                          Colors.white12.withOpacity(0.5),
                                        ]),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      Column(
                                        children: [
                                          // ignore: prefer_const_constructors
                                          Text("",
                                              style: appText(
                                                  color: Colors.white,
                                                  size: 18,
                                                  weight: FontWeight.bold)),
                                          Text(
                                            "",
                                            style: appText(
                                                color: Colors.white,
                                                size: 15,
                                                weight: FontWeight.normal),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        " ",
                                        style: numText(
                                            color: Colors.white,
                                            size: 45,
                                            weight: FontWeight.normal),
                                      ),
                                      Image.asset(
                                        imagePath(id: 301),
                                        scale: 7,
                                        color: Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
