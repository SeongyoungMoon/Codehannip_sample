import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:flutter/material.dart';

class ThemeQuizPracticeCard extends StatefulWidget {
  final String levelTime;
  final String titleText;
  final String projectNum;
  final String contentText;
  final Widget practicePage;
  final String progressNum;
  final bool lastProblem;
  final int index; //stageNum

  ThemeQuizPracticeCard({
    Key key,
    @required this.levelTime,
    @required this.titleText,
    @required this.contentText,
    @required this.practicePage,
    @required this.projectNum,
    @required this.progressNum,
    @required this.lastProblem,
    @required this.index,
  }) : super(key: key);

  @override
  _ThemeQuizPracticeCardState createState() => _ThemeQuizPracticeCardState();
}

class _ThemeQuizPracticeCardState extends State<ThemeQuizPracticeCard> {
  int projectProgress;

  int clearCount = 0; //step badge(*2) 저장값

  List<int> themeProblems =[
    4, 14, 22
  ];

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    if(widget.lastProblem == false){
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserProvider.isTouchCoding()
                          ? Container(
                        padding: EdgeInsets.fromLTRB(24.0, 4.0, 12.0, 4.0),
                        child: Row(
                          children: [
                            Icon(Icons.hourglass_empty, color: Colors.grey),
                            SizedBox(width: 4.0),
                            Text(
                              widget.levelTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
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
                    ],
                  ),
                  Text(
                    widget.projectNum,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 2.0),
                  Text(
                    widget.titleText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.displayLarge),
                  SizedBox(height: 12.0),
                  Text(
                    widget.contentText,
                    // overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium),
                  SizedBox(height: 35.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
    else{
      projectProgress = UserProvider.getUser().themeProgress[widget.progressNum];
      clearCount = UserRepository().theme_clear();
      return Container(
          height: 64,
          padding: EdgeInsets.only(top: 3),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary:
              Theme.of(context).colorScheme.background,
              /*
              UserRepository().isSame(widget.index)//clearCount == themeProblems[widget.index] // step 을 다 풀었으면!
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onPrimary,
              */
              // background
              onPrimary: Colors.white, // foreground
              shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            onPressed: () {
              /*
              clearCount == themeProblems[widget.index]?
              _navigateAndupdate(context, widget.practicePage)
                  : null;
              print("clearCount 는 $clearCount");
              */
              setState(() {
                _lastButtonNav();
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '완성된 프로젝트 실행하기',
                  style: Theme.of(context).textTheme.displayMedium
                  ),
                Container(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: CircleBorder(),
                  ),
                )
              ],
            ),
          )
      );
    }
  }

  Widget _badge(){
    projectProgress = UserProvider.getUser().themeProgress[widget.progressNum];
    if(projectProgress == 2){
      return Image.asset('assets/icons/badge2.png');
    } else {
      return Image.asset('assets/icons/badge0.png');
    }
  }

  Future<dynamic> _lastButtonNav() async {
    /*
    clearCount = UserRepository().theme_clear();
    if(clearCount == themeProblems[widget.index]){ // 이거를 아예 true 와 false 로 보내줘서 확인하도록 해보자
      return _navigateAndupdate(context, widget.practicePage);
    } else {
      return null;
    }
     */
    var isLast = await UserRepository().isSame(widget.index);
    if(isLast == true){
      return _navigateAndupdate(context, widget.practicePage);
    }
    else{
      return null;
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
                  )),
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
