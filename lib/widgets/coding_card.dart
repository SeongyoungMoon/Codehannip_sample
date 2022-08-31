import 'package:flutter/material.dart';

class CodingCard extends StatelessWidget {
  final String type;
  final String value;
  const CodingCard({Key key, this.type, this.value}) : super(key: key);

  static const Color _function = Color(0xFFEE7D7E);
  static const Color _variable = Color(0xFF96AFDB);
  static const Color _dataNumber = Color(0xFF2E91B1);
  static const Color _dataString = Color(0xFF71C084);
  static const Color _controlStatement = Color(0xFFA169A9);
  static const Color _etc = Color(0xFFBBBBBB);
  static const Color _indent = Color(0xFFFFFFFF);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: type == 'function'
              ? _function
              : type == 'controlStatement'
                  ? _controlStatement
                  : type == 'dataString'
                      ? _dataString
                      : type == 'dataNumber'
                          ? _dataNumber
                          : type == 'variable'
                              ? _variable
                              : type == 'indent'
                                ? _indent
                                : _etc,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              value,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        ClipPath(
          clipper: CardClipper(),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                value,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var cut = size.height * 0.5;
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cut);
    path.lineTo(size.width - cut, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
