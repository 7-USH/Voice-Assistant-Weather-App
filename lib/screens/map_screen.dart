// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.coords}) : super(key: key);
  List<double> coords;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  bool isMapCreated = false;
  late double lat ;
  late double lon ;

  @override
  void initState() {
    super.initState();
    lat = widget.coords[0];
    lon = widget.coords[1];
  }

  // ignore: prefer_final_fields
  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  changeMapMode() {
    getJsonFile("assets/maptheme/aubelgume.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {

      var _initialCameraPosition =
        CameraPosition(target: LatLng(lat, lon), zoom: 10);

    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          isMapCreated = true;
          setState(() {
            changeMapMode();
          });
        },
      ),
    );
  }
}
