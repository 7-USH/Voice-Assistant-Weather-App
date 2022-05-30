// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/constants/colors.dart';


class ExplicitLoader extends StatefulWidget {
  ExplicitLoader({Key? key}) : super(key: key);

  @override
  State<ExplicitLoader> createState() => _ExplicitLoaderState();
}

class _ExplicitLoaderState extends State<ExplicitLoader> {
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