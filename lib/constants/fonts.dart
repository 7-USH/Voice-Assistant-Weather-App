import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/constants/colors.dart';

TextStyle appText({required Color color,required double size,required FontWeight weight}) {
  return GoogleFonts.ubuntu(
    color:color,
    fontSize: size,
    fontWeight: weight
  );
}

TextStyle numText({required Color color,required double size,required FontWeight weight}) {
  return GoogleFonts.acme(
    color:color,
    fontSize: size,
    fontWeight: weight
  );
}
