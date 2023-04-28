import 'dart:async';

import 'package:ar_furniture_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  goNext() => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()));
  startdely() {
    timer = Timer(Duration(seconds: 10), () {
      goNext();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startdely();
  }

  Widget buildAnmitedText(String text) => Marquee(
        text: text,
        style: const TextStyle(
            color: Colors.pinkAccent,
            fontSize: 48,
            fontWeight: FontWeight.w900),
        blankSpace: 30,
        velocity: 50,
        pauseAfterRound: const Duration(seconds: 2),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: buildAnmitedText('iKEA Clone'),
      ),
    );
  }
}
