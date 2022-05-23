// ignore_for_file: avoid_print, unnecessary_new, import_of_legacy_library_into_null_safe

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  late double latitude = 0;
  late double longitude = 0;

  Future<List<double>> getCurrentLocation() async {
    List<double> coordinates = [];
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      coordinates.add(position.latitude);
      coordinates.add(position.longitude);
      return coordinates;
    } catch (e) {
      print(e);
    }
    return [0, 0];
  }
}

class GeoCoder {
  Future<dynamic> getPlacemarks(List<double> coords) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(coords[0], coords[1]);
    return placemarks[0].locality;
  }
}
