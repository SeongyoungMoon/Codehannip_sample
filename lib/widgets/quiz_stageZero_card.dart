import 'package:flutter/material.dart';

class QuizStageZeroCard extends StatelessWidget {
  final String step;
  final String titleText;
  final String contentText;
  final Widget conceptPage;

  QuizStageZeroCard({
    Key key,
    @required this.step,
    @required this.titleText,
    @required this.contentText,
    @required this.conceptPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    return Container(
      height: phoneSize.height * 0.28,
      padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  step,
                  style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
            SizedBox(height: 2.0),
            Text(
              titleText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 12.0),
            Text(
              contentText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium),
            Container(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _button(context, "개념 확인하기", conceptPage),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 10,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
    );
  }

  Widget _button(BuildContext context, String btText, Widget page) {
    return Container(
      width: 125.0,
      height: 32.0,
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
          child: Text(btText,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary))),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     blurRadius: 2,
        //     spreadRadius: 0.5,
        //   ),
        // ],
      ),
    );
  }
}
