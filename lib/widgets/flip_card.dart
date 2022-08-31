import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlipCodingCard extends StatefulWidget {
  final String type;
  final String value;
  const FlipCodingCard({Key key, this.type, this.value}) : super(key: key);

  @override
  _FlipCodingCardState createState() => _FlipCodingCardState();
}

class _FlipCodingCardState extends State<FlipCodingCard> {
  var typeKor = '';

  static const Color _function = Color(0xFFEE7D7E);
  static const Color _variable = Color(0xFF96AFDB);
  static const Color _dataNumber = Color(0xFF2E91B1);
  static const Color _dataString = Color(0xFF71C084);
  static const Color _controlStatement = Color(0xFFA169A9);
  static const Color _indent = Color(0xFFFFFFFF);
  static const Color _etc = Color(0xFFBBBBBB);
  static const Color _operator = Color(0xFFF5B13C);

  @override
  Widget build(BuildContext context) {
    typeKor = widget.type == 'function'
        ? '함수'
        : widget.type == 'controlStatement'
            ? '조건문'
            : widget.type == 'dataString'
                ? '문자열'
                : widget.type == 'dataNumber'
                    ? '숫자'
                    : widget.type == 'variable'
                        ? '변수'
                        : widget.type == 'operator'
                          ? '연산자'
                          : widget.type == 'indent'
                            ? '들여쓰기'
                            : '';
    return FlipCard(
      front: coca(widget.value),
      back: coca(typeKor),
      flipOnTouch: false,
    );
  }

  Widget coca(String title) {
    return Stack(
      children: [
        Card(
          color: widget.type == 'function'
              ? _function
              : widget.type == 'controlStatement'
                  ? _controlStatement
                  : widget.type == 'dataString'
                      ? _dataString
                      : widget.type == 'dataNumber'
                          ? _dataNumber
                          : widget.type == 'variable'
                              ? _variable
                              : widget.type == 'operator'
                                ? _operator
                                : widget.type == 'indent'
                                  ? _indent
                                  : _etc,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
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
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
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
