// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/screens/homepage.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();
  GeoCoder coder = GeoCoder();
  WeatherDetails weatherDetails = WeatherDetails();

  @override
  void initState() {
    super.initState();
    pushToNextPage();
  }

  Future<void> pushToNextPage() async {
    getCurrentCoordinates().then((value) {
      getCurrenCity(value).then((n) {
        print(n);
        String query = "Weather in $n";
        getDetails(query).then((v) {
          var result = WeatherModel.fromJson(v);
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return HomePage(
              model: result,
              coords: value,
            );
          }));
        });
      });
    });
  }

  Future<dynamic> getDetails(String query) async {
    var result = await weatherDetails.getData(query);
    return result;
  }

  Future<dynamic> getCurrentCoordinates() async {
    List<double> coords = await location.getCurrentLocation();
    return coords;
  }

  Future<dynamic> getCurrenCity(List<double> coords) async {
    var result = await coder.getPlacemarks(coords);
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
      child: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Colors.white,
          size: 50,
        ),
      ),
    ));
  }
}
