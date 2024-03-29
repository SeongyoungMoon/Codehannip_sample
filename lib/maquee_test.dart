import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';


class maqueeTest extends  StatefulWidget {
  @override
  State<maqueeTest> createState() => _maqueeTestState();
}

class _maqueeTestState extends State<maqueeTest> {
  bool _useRtlText = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marquee',
      home: Scaffold(
        //backgroundColor: Colors.deepOrange,
        body: ListView.builder(
          itemCount: 2,
          shrinkWrap: true ,
          padding: EdgeInsets.only(top: 50.0),
            itemBuilder: (context, index) {
              return Center(
                  child: Marquee(text: 'There once was a boy who told this story about a boy: "')
              );
            },
        ),
      ),
    );
  }

  Widget _buildMarquee() {
    return Marquee(
      key: Key("$_useRtlText"),
      text: !_useRtlText
          ? 'There once was a boy who told this story about a boy: "'
          : 'פעם היה ילד אשר סיפר סיפור על ילד:"',
      velocity: 50.0,
    );
  }

  Widget _buildComplexMarquee() {
    return Marquee(
      key: Key("$_useRtlText"),
      text: !_useRtlText
          ? 'Some sample text that takes some space.'
          : 'זהו משפט ראשון של הטקסט הארוך. זהו המשפט השני של הטקסט הארוך',
      style: TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: 3,
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(height: 50.0, color: Colors.white, child: child),
    );
  }
}