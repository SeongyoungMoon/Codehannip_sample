import 'dart:async';

import 'package:flutter/material.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Image.asset('assets/icons/splash.png'))
            ],
    )));
  }

  Timer startTimer() {
    var duration = Duration(milliseconds: 3000);
    return Timer(duration, (){});
  }
}
