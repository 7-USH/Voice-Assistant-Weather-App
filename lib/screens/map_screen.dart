// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, must_be_immutable, unused_field, unused_local_variable, avoid_print, prefer_collection_literals, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/weatherModel.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.coords, required this.model}) : super(key: key);
  List<double> coords;
  WeatherModel model;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  bool isMapCreated = false;
  late double lat;
  late double lon;
  Set<Marker> _markers = Set<Marker>();
  late BitmapDescriptor sourceMarker;
  bool mapTap = false;

  void setCustomMarker() async {
    sourceMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 12)),
        "assets/weather/blue_marker.png");
  }

  @override
  void initState() {
    super.initState();
    lat = widget.coords[0];
    lon = widget.coords[1];
    setCustomMarker();
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  changeMapMode() {
    getJsonFile("assets/maptheme/aubelgume.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("Source-1"),
        position: LatLng(lat, lon),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onTap: () {
          
        },
      ));
    });
  }

  static const CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 1.0);

  @override
  Widget build(BuildContext context) {
    var _finalCameraPosition =
        CameraPosition(target: LatLng(lat, lon), zoom: 10);

    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        onTap: (location) {
          setState(() {
            _markers.add(Marker(
                markerId: MarkerId("Source-2"),
                position: LatLng(location.latitude, location.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                onTap: () {
                  _markers.remove(_markers.elementAt(1));
                  setState(() {});
                }));
          });
        },
        markers: _markers,
        compassEnabled: false,
        mapToolbarEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          showPinsOnMap();
          Future.delayed(Duration(seconds: 1)).then((value) {
            _controller.animateCamera(
                CameraUpdate.newCameraPosition(_finalCameraPosition));
          });
          isMapCreated = true;
          setState(() {
            changeMapMode();
          });
        },
      ),
    );
  }
}
