// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:weather_app/models/command.dart';

class MessageBlob extends StatefulWidget {
  MessageBlob({Key? key, required this.command, required this.who})
      : super(key: key);
  Command command;
  Enum who;

  @override
  State<MessageBlob> createState() => _MessageBlobState();
}

class _MessageBlobState extends State<MessageBlob> {
  CrossAxisAlignment alignment = CrossAxisAlignment.start;
  Color messageColor = botBlobColor;

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
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
              color: blobColor,
              gradient: LinearGradient(
                  colors: [messageColor, messageColor.withOpacity(0.6)]),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            widget.command.text,
            textAlign: TextAlign.justify,
            style: messageFont(
                color: Colors.white, size: 20, weight: FontWeight.normal),
          ),
        )
      ]),
    );
  }
}
