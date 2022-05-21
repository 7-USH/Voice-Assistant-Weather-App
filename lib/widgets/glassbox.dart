// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  GlassBox({Key? key,required this.height}) : super(key: key);
  double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(),
              )
            ],
          )),
    );
  }
}
