import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/fonts.dart';


class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor.withOpacity(0.98),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.error,color: Colors.yellow,size: 40,),
            const SizedBox(height: 20,),
            Text("Ops Sorry there seems to an error!",style: appText(color: Colors.white, weight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}