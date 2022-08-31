import 'package:flutter/material.dart';
import 'package:code_hannip/providers/user_provider.dart';

class QuizStageCard extends StatefulWidget {
  final String conceptNum; //DB: User -> conceptProgress[conceptNum]
  final String step;
  final String titleText;
  final String contentText;
  final Widget conceptPage;
  final Widget examplePage;

  QuizStageCard({
    Key key,
    @required this.conceptNum,
    @required this.step,
    @required this.titleText,
    @required this.contentText,
    @required this.conceptPage,
    @required this.examplePage,
  }) : super(key: key);

  @override
  _QuizStageCardState createState() => _QuizStageCardState();
}

class _QuizStageCardState extends State<QuizStageCard> {
  int conceptProgress;

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: phoneSize.width * 0.05,
            vertical: phoneSize.height * 0.02
        ),
        child: Stack(
          children: [
            Positioned(
              right: phoneSize.height * 0.001,
              height: phoneSize.height * 0.09,
              child: _badge(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.step,
                      style: Theme.of(context).textTheme.headlineMedium.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                SizedBox(height: 2.0),
                Text(
                  widget.titleText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                ),
                SizedBox(height: 12.0),
                Text(
                  widget.contentText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                ),
                //Expanded(child: Container()),
                Container(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                    width: 125.0,
                    height: 32.0,
                      child: FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                          onPressed: () {
                            _navigateAndupdate(context, widget.conceptPage);
                          },
                          child: Text("개념확인하기",
                              style: Theme.of(context).textTheme.labelLarge
                                  .copyWith(color: Theme.of(context).colorScheme.primary))),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                     ),
                    SizedBox(width: 8.0),
                    Container(
                      width: 125.0,
                      height: 32.0,
                      child: FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                          onPressed: () {
                            _navigateAndupdate(context, widget.examplePage);
                          },
                          child: Text("예제확인하기", style: Theme.of(context).textTheme.labelLarge
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary))),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
    );
  }

  Widget _badge(){
    conceptProgress = UserProvider.getUser().conceptProgress[widget.conceptNum];
    if(conceptProgress == 1){
      return Image.asset('assets/icons/badge1.png');
    } else if(conceptProgress == 2){
      return Image.asset('assets/icons/badge2.png');
    } else {
      return Image.asset('assets/icons/badge0.png');
    }
  }

  // Widget _button(BuildContext context, String btText, Widget page) {
  //   return Container(
  //     width: 125.0,
  //     height: 32.0,
  //     child: FlatButton(
  //         padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
  //         onPressed: () {
  //           _navigateAndupdate(context, page);
  //         },
  //         child: Text(btText,
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .labelLarge
  //                 .copyWith(color: Theme.of(context).colorScheme.onPrimary))),
  //             decoration: BoxDecoration(
  //               color: Theme.of(context).colorScheme.primary,
  //               borderRadius: BorderRadius.all(Radius.circular(16.0)),
  //               // boxShadow: [
  //               //   BoxShadow(
  //               //     color: Colors.grey.withOpacity(0.5),
  //               //     blurRadius: 2,
  //               //     spreadRadius: 0.5,
  //               //   ),
  //               // ],
  //             ),
  //   );
  // }

  _navigateAndupdate(BuildContext context, Widget page) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page)
          ).then((value) => setState(() {}));

  }
}
