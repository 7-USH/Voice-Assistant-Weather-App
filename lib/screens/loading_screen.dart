// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/screens/homepage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();
  GeoCoder geoCoder = GeoCoder();
  WeatherDetails weatherDetails = WeatherDetails();

  @override
  void initState() {
    super.initState();
    getCurrentCoords().then((value) {
      getCurrentCity(value).then((n) {
        print(n);
        String query = "Weather in $n";
        getDetails(query).then((value) {
          var result = WeatherModel.fromJson(value);
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return HomePage(model: result);
          }));
        });     
      });
    });
  }

  Future<dynamic> getDetails(String query) async {
    return await weatherDetails.getData(query);
  }

  Future<dynamic> getCurrentCoords() async {
    List<double> coords = await location.getCurrentLocation();
    return coords;
  }

  Future<dynamic> getCurrentCity(List<double> coords) async {
    var result = await geoCoder.getPlacemarks(coords);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color: textColor,
            size: 50,
          ),
        ));
  }
}
