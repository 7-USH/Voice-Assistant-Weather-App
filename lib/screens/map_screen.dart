// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, must_be_immutable, unused_field, unused_local_variable, avoid_print, prefer_collection_literals, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/widgets/point_weather.dart';

const double pinInvisible = -300;
const double pinVisible = -20;

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.coords, required this.model})
      : super(key: key);
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
  bool sourceTap = false;
  GeoCoder coder = GeoCoder();
  WeatherDetails details = WeatherDetails();

  late String cityName;
  late int temp;
  late int id;
  bool isLoading = false;

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
    getCurrentLocationDetails();
  }

  void getCurrentLocationDetails() {
    cityName = widget.model.name!;
    temp = widget.model.main!.temp!.toInt();
    id = widget.model.weather!.id!.toInt();
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
          myBottomModalSheet(id, cityName, temp);
        },
      ));
    });
  }

  myBottomModalSheet(int id1, String cityname1, int temp1) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        context: context,
        constraints: BoxConstraints(maxHeight: 300),
        builder: (_) {
          return PointWeather(id: id1, name: cityname1, temp: temp1);
        });
  }

  static const CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 1.0);

  @override
  Widget build(BuildContext context) {
    var _finalCameraPosition =
        CameraPosition(target: LatLng(lat, lon), zoom: 10);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomGesturesEnabled: true,
          onTap: (location) {
            setState(() {
              _markers.add(Marker(
                  markerId: MarkerId("Source-2"),
                  position: LatLng(location.latitude, location.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  onTap: () {
                    coder.getPlacemarks(
                        [location.latitude, location.longitude]).then((value) {
                      print(value);
                      if (value != "") {
                        setState(() {
                          isLoading = true;
                        });
                        details.getData("Weather in $value").then((v) {
                          if (v != null) {
                            WeatherModel model = WeatherModel.fromJson(v);
                            myBottomModalSheet(
                                model.weather!.id!.toInt(),
                                model.name.toString(),
                                model.main!.temp!.toInt());
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: "There was some error");
                      }
                    });
                  }));
            });
          },
          markers: _markers,
          compassEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
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
        isLoading
            ? Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  child: LoadingAnimationWidget.fallingDot(
                    color: Colors.white,
                    size: 40,
                  ),
                ))
            : Container()
      ]),
    );
  }
}
