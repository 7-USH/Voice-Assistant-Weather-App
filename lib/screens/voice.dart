// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';


class VoicePage extends StatefulWidget {
  const VoicePage({Key? key}) : super(key: key);

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textColor,
                    boxShadow: kButtonShadows
                ),
                child: Center(
                  child: IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(
                        FontAwesomeIcons.microphone,
                        color: Colors.white,
                        size: 25,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: bgColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Hello, \nmy name is Cody",style: botFont(color: Colors.white, size: 38, weight: FontWeight.w800),),
          const SizedBox(height: 20,),
          Text("How can I help you?",style: botFont(color: Colors.grey.withOpacity(1), size: 20, weight: FontWeight.w600),)
        ]),
      ),
    );
  }
}
