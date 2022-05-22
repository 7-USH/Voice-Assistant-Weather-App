// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_element, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison, unused_field
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:weather_app/models/command.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/glassbox.dart';
import 'package:weather_app/widgets/messageblob.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({Key? key}) : super(key: key);

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  late SpeechToText _speechToText;
  bool _isListening = false;
  bool onstatus = false;
  double _height = 0;
  Color red = Colors.red;
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  List<Command> messages = [Command(text: "Good morning")];
  late String _text;
  final ItemScrollController _scrollController = ItemScrollController();
  Enum who = Who.user;
  WeatherDetails weatherDetails = WeatherDetails();

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
  }

  Future<String> getDetails(String query) async {
    return await weatherDetails.getData(query);
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
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
      backgroundColor: bgColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Hello, \nmy name is Cody",
            style:
                botFont(color: Colors.white, size: 38, weight: FontWeight.w600),
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
                height: size.height / 2,
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
                        if (index % 2 == 0) {
                          who = Who.bot;
                        } else {
                          who = Who.user;
                        }
                        return MessageBlob(
                          command: messages[index],
                          who: who,
                        );
                      }),
                )),
            GlassBox(
              height: _height,
            ),
          ])
        ]),
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
            onResult: (result) => setState(() {
                  _text = result.recognizedWords;
                  _isListening = false;
                  if (_text != "") {
                    messages.add(Command(text: _text));
                    if (_text.contains("weather") ||
                        _text.contains("Weather")) {
                      getDetails(_text).then((value) => print(value));
                    }
                    _scrollController.scrollTo(
                        index: messages.length - 1,
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
