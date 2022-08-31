import 'package:flutter/material.dart';

class DoneDialog extends StatelessWidget {
  final bool isCorrect;
  final bool noChoice;
  final Function function;
  final String hint;

  const DoneDialog({Key key, this.isCorrect, this.function, this.noChoice, this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _hintNull = false;
    if(hint == null) _hintNull = true;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      title: Center(
        child: noChoice
            ? Text('정답을 선택해주세요.')
            : isCorrect
                ? Text('정답! 잘했어요!')
                : Text('괜찮아요! 다시 해봐요!'),
      ),
      content: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: 220,
          child: Column(
            children: [
              Container(
                child: SizedBox(
                  width: 150,
                  height: 180,
                  child: isCorrect
                      ? Image.asset('assets/images/answer.png', fit: BoxFit.cover)
                      : Image.asset('assets/images/incorrect.png', fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                child: Text(
                  _hintNull ? "" : hint,
                  //style: Theme.of(context).textTheme.headline4,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FlatButton(
              onPressed: function,
              child: Text(
                isCorrect ? "목록으로 돌아가기" : "문제로 돌아가기",
                style: Theme.of(context).textTheme.subtitle1,
              )),
        )
      ],
    );
  }
}
