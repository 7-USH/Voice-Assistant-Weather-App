// ignore_for_file: avoid_print, unused_local_variable
import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherDetails {
  Future<dynamic> getData(String text) async {
    http.Response response = await http
        .get(Uri.parse('https://my-api09.herokuapp.com/api?query=$text'));
    if (response.statusCode == 200) {
      dynamic data = await jsonDecode(response.body);
      return data;
    }
    return "error";
  }

  Future<dynamic> getNextData(String city) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=acc9068ec2056e6e17c02844aa9ca5b8'));
    if (response.statusCode == 200) {
      dynamic data = await jsonDecode(response.body);
      return data['list'];
    }
    return Future.error("There's some issue");
  }
}
