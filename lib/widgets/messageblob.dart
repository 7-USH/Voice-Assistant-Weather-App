// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/command.dart';
import 'package:weather_app/models/weather_image.dart';

class MessageBlob extends StatefulWidget {
  MessageBlob(
      {Key? key, required this.command, required this.who, this.temp, this.id})
      : super(key: key);
  Command command;
  Enum who;
  int? temp;
  int? id;

  @override
  State<MessageBlob> createState() => _MessageBlobState();
}

class _MessageBlobState extends State<MessageBlob> {
  CrossAxisAlignment alignment = CrossAxisAlignment.start;
  Color messageColor = Colors.white12;
  String date = "03-Mar-2022";
  String image = "assets/weather/Zaps.png";

  @override
  void initState() {
    super.initState();
    updateUi();
  }

  void updateUi() {
    setState(() {
      DateTime today = DateTime.now();
      DateFormat formatter = DateFormat("d MMM");
      date = formatter.format(today);
      image = imagePath(id: widget.id ?? 501);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.who == Who.user) {
      alignment = CrossAxisAlignment.end;
      messageColor = blobColor;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: alignment, children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 310),
          decoration: BoxDecoration(
              color: blobColor,
              gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.topLeft,
                  colors: [
                    messageColor,
                    messageColor.withOpacity(0.5),
                  ]),
              borderRadius: BorderRadius.circular(20)),
          child: widget.temp == null
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    widget.command.text,
                    textAlign: TextAlign.left,
                    style: messageFont(
                        color: Colors.white,
                        size: 18,
                        weight: FontWeight.normal),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      image,
                      scale: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today, $date",
                          style: botFont(
                              color: Colors.white,
                              size: 18,
                              weight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          widget.temp.toString() + "°",
                          style: botFont(
                              color: Colors.white,
                              size: 60,
                              weight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
        )
      ]),
    );
  }
}
