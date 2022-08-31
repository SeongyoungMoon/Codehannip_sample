import 'package:flutter/material.dart';

class QuizLogicScreen extends StatefulWidget {
  @override
  _QuizLogicScreenState createState() => _QuizLogicScreenState();
}

class _QuizLogicScreenState extends State<QuizLogicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("로직짜기 페이지"),
      ),
    );
  }
}
