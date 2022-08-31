import 'package:code_hannip/providers/user_provider.dart';
import 'package:flutter/material.dart';

class QuizPracticeCard extends StatefulWidget {
  final String levelTime;
  final String titleText;
  final String projectNum;
  final String contentText;
  final Widget practicePage;
  final String progressNum;

  QuizPracticeCard({
    Key key,
    @required this.levelTime,
    @required this.titleText,
    @required this.contentText,
    @required this.practicePage,
    @required this.projectNum,
    @required this.progressNum,
  }) : super(key: key);

  @override
  _QuizPracticeCardState createState() => _QuizPracticeCardState();
}

class _QuizPracticeCardState extends State<QuizPracticeCard> {
  int projectProgress;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.projectNum,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium
                      // .copyWith(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18.0)
                  ,
                ),
                SizedBox(height: 2.0),
                Text(
                  widget.titleText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.displayLarge
                      // .copyWith(
                      // color: Theme.of(context).colorScheme.onPrimary, fontSize: 20.0)
                  ,
                ),
                SizedBox(height: 12.0),
                Text(
                  widget.contentText,
                  // overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                ),
                SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UserProvider.isTouchCoding()
                        ? Container(
                           height: 32.0,
                           width: 125.0,
                           padding: EdgeInsets.fromLTRB(24.0, 4.0, 12.0, 4.0),
                            child: Row(
                              children: [
                                Icon(Icons.timer, color: Theme.of(context).colorScheme.primary),
                                SizedBox(width: 4.0),
                                Text(
                              widget.levelTime,
                              style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Theme.of(context).colorScheme.primary
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    )
                        : Container(),
                    SizedBox(width: 8.0),
                    _button(context, "문제 풀러가기", widget.practicePage),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).colorScheme.surface,
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(24.0),
      //   ),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       spreadRadius: 1,
      //       blurRadius: 10,
      //       offset: Offset(0, 3), // changes position of shadow
      //     ),
      //   ],
      // ),
    );
  }

  Widget _badge(){
    projectProgress = UserProvider.getUser().projectProgress[widget.progressNum];
    if(projectProgress == 2){
      return Image.asset('assets/icons/badge2.png');
    } else {
      return Image.asset('assets/icons/badge0.png');
    }
  }

  Widget _button(BuildContext context, String btText, Widget page) {
    return Container(
      width: 125.0,
      height: 32.0,
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          onPressed: () {
            _navigateAndupdate(context, page);
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

  _navigateAndupdate(BuildContext context, Widget page) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page)
    ).then((value) => setState(() {}));

  }
}
