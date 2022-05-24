// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_element, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison, unused_field, unused_local_variable, no_leading_underscores_for_local_identifiers, must_be_immutable
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:weather_app/models/command.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/widgets/glassbox.dart';
import 'package:weather_app/widgets/messageblob.dart';

class VoicePage extends StatefulWidget {
  VoicePage({Key? key, required this.model}) : super(key: key);
  WeatherModel model;

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  late SpeechToText _speechToText;
  bool _isListening = false;
  double _height = 0;
  Color red = Colors.red;
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  List<Command> messages = [Command(text: "Hey there!", who: Who.bot)];
  late String _text;
  final ItemScrollController _scrollController = ItemScrollController();
  Enum who = Who.user;
  WeatherDetails weatherDetails = WeatherDetails();

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
  }

  Future<dynamic> getDetails(String query) async {
    return await weatherDetails.getData(query);
  }

  int? celsiusCalc(int? kelvin) {
    if (kelvin == null) {
      return null;
    }
    return kelvin - 273;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
          animate: _isListening,
          endRadius: 90,
          glowColor: textColor,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: GestureDetector(
            onTap: _listen,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: blobColor,
                  gradient: LinearGradient(colors: [
                    _isListening ? blobColor : red,
                    _isListening
                        ? blobColor.withOpacity(0.6)
                        : red.withOpacity(0.6)
                  ])),
              child: Icon(
                _isListening ? FontAwesomeIcons.microphone : Icons.mic_off,
                color: Colors.white,
              ),
            ),
          )),
      backgroundColor: darkColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
              0.1,
              0.9
            ],
                colors: [
              darkColor,
              bgColor,
            ])),
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Hello, \nmy name is Cody",
              style: botFont(
                  color: Colors.white,
                  size: size.height / 22.5,
                  weight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _isListening ? "Listening..." : "How can I help you?",
              style: messageFont(
                  color: Colors.white54, size: 20, weight: FontWeight.w600),
            ),
            Stack(children: [
              Container(
                  height: size.height / 1.9,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.topRight,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: ScrollablePositionedList.builder(
                        itemPositionsListener: itemPositionsListener,
                        itemScrollController: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return MessageBlob(
                            command: messages[index],
                            who: messages[index].who,
                            temp: messages[index].temp,
                            id: messages[index].id,
                          );
                        }),
                  )),
              GlassBox(
                height: _height,
              ),
            ])
          ]),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) {
          print('OnStatus : $val');
          if (val == "notListening" || val == "done") {
            _isListening = false;
            setState(() {});
          }
        },
        onError: (val) {
          print('OnError : $val');
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
        });
        await _speechToText.listen(
            cancelOnError: true,
            partialResults: false,
            pauseFor: Duration(seconds: 3),
            onResult: (result) => setState(() {
                  _text = result.recognizedWords;
                  if (_text != "") {
                    messages.add(Command(text: _text.trim(), who: Who.user));

                    if (_text.contains("weather") ||
                        _text.contains("Weather") ||
                        _text.contains("temperature") ||
                        _text.contains("forecast")) {
                      getDetails(_text).then((value) {
                        var result = WeatherModel.fromJson(value);

                        if (result.weather == null) {
                          if ((_text.contains("today's") &&
                                  _text.contains("weather")) ||
                              (_text.contains("today") &&
                                  _text.contains("weather"))) {
                            int? temp =
                                celsiusCalc(widget.model.main?.temp?.toInt());
                            String? placeName = widget.model.name;

                            setState(() {
                              messages.add(Command(
                                  text:
                                      "Showing the weather in $placeName for today",
                                  who: Who.bot));
                              messages.add(Command(
                                  text: widget.model.weather?.description ??
                                      "Sorry there's some issue.",
                                  who: Who.bot,
                                  temp: temp));
                            });
                          } else {
                            setState(() {
                              messages.add(Command(
                                  text: "Sorry there's some issue.",
                                  who: Who.bot));
                            });
                          }
                          _isListening = false;
                          _scrollController.scrollTo(
                              index: messages.length - 1,
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 1000));
                        } else {
                          setState(() {
                            String? description = result.weather?.description;
                            int? temp = celsiusCalc(result.main?.temp?.toInt());
                            int? id = result.weather?.id?.toInt();
                            String? placeName = result.name;

                            if (_text.contains("temperature") &&
                                placeName != null) {
                              messages.add(Command(
                                  text:
                                      "Current Temperature in $placeName is $temp °C",
                                  who: Who.bot));
                            } else if (_text.contains("weather")) {
                              if (placeName != null) {
                                messages.add(Command(
                                    text:
                                        "Showing the weather in $placeName for today",
                                    who: Who.bot));
                              }

                              messages.add(Command(
                                  text: description ??
                                      "Sorry there's some issue.",
                                  temp: temp,
                                  id: id,
                                  who: Who.bot));
                            } else if (_text.contains("forecast")) {
                              messages.add(Command(
                                  text:
                                      description ?? "Sorry there's some issue",
                                  who: Who.bot));
                            }

                            _isListening = false;
                            _scrollController.scrollTo(
                                index: messages.length - 1,
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 1000));
                          });
                        }
                      });
                    } else {
                      messages.add(Command(text: "Excuze Me?", who: Who.bot));
                    }
                    _isListening = false;
                    _scrollController.scrollTo(
                        index: messages.length,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 1000));

                    if (itemPositionsListener
                            .itemPositions.value.first.itemLeadingEdge <
                        0) {
                      _height = 50;
                    }
                  }
                }));
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speechToText.stop();
    }
  }
}
