import 'package:flutter/material.dart';

class SubDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("로그인 필요!"),
      ),
      content: SizedBox(
        width: 150,
        child: Text(
          "해당 기능을 이용하고 싶다면\n로그인이 필요합니다. (◞‸◟)"
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FlatButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text(
                "취소",
                style: Theme.of(context).textTheme.subtitle1,
              )),
        ),
      ],
    );
  }
}
