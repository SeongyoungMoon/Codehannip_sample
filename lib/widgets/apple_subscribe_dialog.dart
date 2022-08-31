import 'package:flutter/material.dart';

class AppleSubDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("서비스 준비중입니다"),
      ),
      content: SizedBox(
        width: 150,
        child: Text(
            "조금만 기다려주세요! 곧 iOS용 구독 서비스가 추될 예정입니다. (◞‸◟)"
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
