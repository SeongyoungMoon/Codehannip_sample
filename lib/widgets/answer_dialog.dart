import 'package:flutter/material.dart';

class AnswerDialog extends StatelessWidget {
  final bool isCorrect;
  final Function function;

  const AnswerDialog({Key key, this.isCorrect, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: isCorrect ? Text('정답! 잘했어요!') : Text('괜찮아요! 다시 해봐요!'),
      ),
      content: SizedBox(
        width: 150,
        height: 180,
        child: isCorrect
            ? Image.asset('assets/images/answer.png', fit: BoxFit.cover)
            : Image.asset('assets/images/incorrect.png', fit: BoxFit.cover),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FlatButton(
              onPressed: isCorrect
                  ? function
                  : () {
                      Navigator.pop(context);
                    },
              child: Text(
                isCorrect ? "다음으로 넘어가기" : "문제로 돌아가기",
                style: Theme.of(context).textTheme.bodySmall,
              )),
        )
      ],
    );
  }
}
