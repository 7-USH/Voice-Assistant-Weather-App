import 'package:flutter/material.dart';

Color darkColor = const Color(0xff0b0c1e);
Color skyBlue = const Color(0xff1d93eb);
Color greyColor = const Color(0xff85858e);
Color whiteColor = const Color(0xffffffff);
Color brown = const Color(0xff342019);
Color bgColor = const Color(0xff273950);
Color darkBgColor = const Color(0xff23263D);
Color textColor = const Color(0xff23B3F2);
Color blobColor = const Color(0xff49A8F3);
Color botBlobColor = const Color(0xff272B3E);

List<BoxShadow> kBoxShadows = [
  BoxShadow(
      color: darkBgColor,
      offset: const Offset(5, 10),
      spreadRadius: 3,
      blurRadius: 12),
  BoxShadow(
      color: Colors.white.withOpacity(0.8),
      blurRadius: 5)
];

List<BoxShadow> kButtonShadows = [
  BoxShadow(
      color: Colors.black.withOpacity(0.2),
      offset: const Offset(0.6, 4),
      spreadRadius: 1,
      blurRadius: 8)
];
