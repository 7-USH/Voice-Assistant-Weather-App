// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/command.dart';

class MessageBlob extends StatefulWidget {
  MessageBlob({Key? key, required this.command, required this.who, this.temp,this.id})
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
          padding: const EdgeInsets.all(18),
          constraints: const BoxConstraints(maxWidth: 300),
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
          child: widget.temp==null && widget.who==Who.bot ? Text(
            widget.command.text,
            textAlign: TextAlign.left,
            style: messageFont(
                color: Colors.white, size: 18, weight: FontWeight.normal),
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                  "assets/weather/Sun_cloud_little_rain.png",
                ),
                Column()
            ],
          ),
        )
      ]),
    ) ;
  }
}
