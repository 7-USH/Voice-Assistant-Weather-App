// ignore_for_file: avoid_print, unused_local_variable
import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherDetails {
  Future<String> getData(String text) async {
    http.Response response = await http.get(Uri.parse('https://my-api09.herokuapp.com/api?query=$text'));
    if (response.statusCode == 200) {
      dynamic data = await jsonDecode(response.body);
      return data.toString();
    }
    return "error";
  }
}
