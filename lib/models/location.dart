// ignore_for_file: avoid_print, unnecessary_new, import_of_legacy_library_into_null_safe, unused_local_variable, unnecessary_null_comparison

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  Future<List<double>> getCurrentLocation() async {
    List<double> coordinates = [];
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      Fluttertoast.showToast(msg: 'Location service are disabled');
      return Future.error('Location service are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permissions are denied');
        return Future.error('Location permission are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: 'Location permissions are permanently denied');
      return Future.error('Location permission denied forever');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);

    if (position == null) {
      return [0, 0];
    }

    coordinates.add(position.latitude);
    coordinates.add(position.longitude);

    return coordinates;
  }
}

class GeoCoder {
  Future<dynamic> getPlacemarks(List<double> coords) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        coords[0], coords[1],
        localeIdentifier: "en");
    return placemarks[0].locality;
  }
}
