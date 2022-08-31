import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/firestore_path.dart';
import 'package:code_hannip/services/firestore_service.dart';
import 'package:code_hannip/ui/quiz/quiz_pt_select_screen.dart';
import 'package:code_hannip/ui/quiz_stage_zero/quiz_stgZero_screen.dart';
import 'package:code_hannip/ui/setting/setting_screen.dart';
import 'package:code_hannip/ui/subscribe/subscribe_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'quiz_stg_select_screen.dart';
import 'package:code_hannip/providers/purchase_provider.dart';

class QuizMainScreen extends StatefulWidget {

  @override
  _QuizMainScreenState createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends State<QuizMainScreen> {

  var stage = 3; // todo: 지금까지 나온 스테이지 개수, 나중엔 db에서 불러와야함
  bool sub = false; // subscripted or not


  List<int> stageCount = [
    1, 4, 5, 2, 3, 2, 3, 3, 0, 3, 1, 3, 0, 2, 0, 4, 0, 4, 0, 3, 0, 4, 0, 3, 0, 3, 0, 3, 0, 0
  ];

  List<String> stageNameList = [
    "프로그래밍의 이해",
    "자료형 개념",
    "자료형 실전",
    "변수 개념",
    "변수 실전",
    "입출력 개념",
    "입출력 실전",
    "연산자 개념",
    "연산자 실전",
    "제어문",
    "제어문 실전",
    "반복문",
    "반복문 실전",
    "문자열의 응용의 개념",
    "문자열의 응용의 실전",
    "문자열함수1",
    "문자열함수1 실전",
    "문자열함수2",
    "문자열함수2 실전",
    "리스트 개념",
    "리스트 실전",
    "리스트의 연산 개념",
    "리스트의 연산 실전",
    "리스트 함수1 개념",
    "리스트 함수1 실전",
    "리스트 함수2 개념",
    "리스트 함수2 실전",
    "사용자 정의 함수 개념",
    "사용자 정의 함수 실전",
    "내장 함수1 개념",
    "내장 함수1 실전",
    "내장 함수2 개념",
    "내장 함수2 실전",
    "내장 함수3 응용",
    "내장 함수3 실전",
  ];

  List<String> images_unlock = [
    'assets/images/stage0.png',
    'assets/images/stage1.png',
    'assets/images/stage1s.png',
    'assets/images/stage2.png',
    'assets/images/stage2s.png',
    'assets/images/stage3.png',
    'assets/images/stage3s.png',
    'assets/images/stage4.png',
    'assets/images/stage4s.png',
    'assets/images/stage5.png',
    'assets/images/stage5s.png',
    'assets/images/stage6.png',
    'assets/images/stage6s.png',
    'assets/images/stage7.png',
    'assets/images/stage7s.png',
    'assets/images/stage8.png',
    'assets/images/stage8s.png',
    'assets/images/stage9.png',
    'assets/images/stage9s.png',
    'assets/images/stage10.png',
    'assets/images/stage10s.png',
    'assets/images/stage11.png',
    'assets/images/stage11s.png',
    'assets/images/stage12.png',
    'assets/images/stage12s.png',
    'assets/images/stage13.png',
    'assets/images/stage13s.png',
    'assets/images/stage14.png',
    'assets/images/stage14s.png',
    'assets/images/stage15.png',
    'assets/images/stage15s.png',
    'assets/images/stage16.png',
    'assets/images/stage16s.png',
    'assets/images/stage17.png',
    'assets/images/stage17s.png',
  ];

  List<String> images_lock = [
    'assets/images/stage0L.png',
    'assets/images/stage1L.png',
    'assets/images/stage1SL.png',
    'assets/images/stage2L.png',
    'assets/images/stage2SL.png',
    'assets/images/stage3L.png',
    'assets/images/stage3SL.png',
    'assets/images/stage4L.png',
    'assets/images/stage4SL.png',
    'assets/images/stage5L.png',
    'assets/images/stage5SL.png',
    'assets/images/stage6L.png',
    'assets/images/stage6SL.png',
    'assets/images/stage7L.png',
    'assets/images/stage7SL.png',
    'assets/images/stage8L.png',
    'assets/images/stage8SL.png',
    'assets/images/stage9L.png',
    'assets/images/stage9SL.png',
    'assets/images/stage10L.png',
    'assets/images/stage10SL.png',
    'assets/images/stage11L.png',
    'assets/images/stage11SL.png',
    'assets/images/stage12L.png',
    'assets/images/stage12SL.png',
    'assets/images/stage13L.png',
    'assets/images/stage13SL.png',
    'assets/images/stage14L.png',
    'assets/images/stage14SL.png',
    'assets/images/stage15L.png',
    'assets/images/stage15SL.png',
    'assets/images/stage16L.png',
    'assets/images/stage16SL.png',
    'assets/images/stage17L.png',
    'assets/images/stage17SL.png',
  ];

  List<String> images_done = [
    'assets/images/stage0D.png',
    'assets/images/stage1D.png',
    'assets/images/stage1SD.png',
    'assets/images/stage2D.png',
    'assets/images/stage2SD.png',
    'assets/images/stage3D.png',
    'assets/images/stage3SD.png',
    'assets/images/stage4D.png',
    'assets/images/stage4SD.png',
    'assets/images/stage5D.png',
    'assets/images/stage5SD.png',
    'assets/images/stage6D.png',
    'assets/images/stage6SD.png',
    'assets/images/stage7D.png',
    'assets/images/stage7SD.png',
    'assets/images/stage8D.png',
    'assets/images/stage8SD.png',
    'assets/images/stage9D.png',
    'assets/images/stage9SD.png',
    'assets/images/stage10D.png',
    'assets/images/stage10SD.png',
    'assets/images/stage11D.png',
    'assets/images/stage11SD.png',
    'assets/images/stage12D.png',
    'assets/images/stage12SD.png',
    'assets/images/stage13D.png',
    'assets/images/stage13SD.png',
    'assets/images/stage14D.png',
    'assets/images/stage14SD.png',
    'assets/images/stage15D.png',
    'assets/images/stage15SD.png',
    'assets/images/stage16D.png',
    'assets/images/stage16SD.png',
    'assets/images/stage17D.png',
    'assets/images/stage17SD.png',
  ];

  List<String> images = [];

  List progress = [];
  List userProgress = [];

  bool _useRtlText = false;

  @override
  void initState() {
    super.initState();
    userProgressGet();
    var provider = Provider.of<ProviderModel>(context, listen: false);
    print("main");
    provider.verifyPurchase();
    sub = provider.isPurchased;
  }


  @override
  Widget build(BuildContext context) {
    //_json();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    Widget text() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Notice').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return Container(
                height: height*0.042,
                color: Colors.white,
                child: ListView(
                  children: snapshot.data.docs.map((
                      DocumentSnapshot document) {

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          padding: EdgeInsets.fromLTRB(12.0, 4.0, 8.0, 5.0),
                          child: Icon(
                            Icons.campaign_outlined,
                            color: Theme.of(context).colorScheme.onBackground,
                            size: 20,
                          ),
                        ),

                        Text(
                          document['contents'],
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                          textAlign: TextAlign.start,
                        ),

                      ],
                    );
                  }).toList(),
                ),
              );
          }
        },
      );
    }

    Widget text2() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Notice').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: snapshot.data.docs.map((
                          DocumentSnapshot document) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: height*0.055,
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(12.0, 5.0, 8.0, 4.0),
                              child: Icon(
                                Icons.campaign_outlined,
                                color: Theme.of(context).colorScheme.onBackground,
                                size: 22,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height*0.055,
                                color: Colors.white,
                                child: ScrollingText(
                                  text: document['contents'],
                                  textStyle: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
          }
        },
      );
    }



    //todo: userprogress값 계속 파베에서 불러와야돼
    _images();
    var level = UserRepository().checkStageLock();


    //var level = UserRepository().checkStageLock();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '터치 코딩',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          automaticallyImplyLeading: false,
          actions: [
            /*
            FlatButton(
              child: Icon(
                Icons.settings,
                size: 24.0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SettingScreen()));
              },
            )*/
          ],
        ),
        //backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: TransformerPageView(
                index: level,
                  loop: false,
                  transformer: AccordionTransformer(),
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.contain,
                              height: height*0.35,
                            ),
                            onTap: () {
                              _navigator(index);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),

                          //여기서 총 card 수랑 concept progress 값 받아야함
                          //ㄷㅏ음 업뎃에 추가 ^^;;
                          /*
                         Text(
                            "${userProgress[index]}/${progress[index]}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          */
                          SizedBox(
                            height: height*0.18,
                          ),
                          /*
                          Text(
                            "STAGE ${(index + 1) ~/ 2}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(height: 6.0),
                          AutoSizeText(
                            stageNameList[index],
                            //style: Theme.of(context).textTheme.headline3,
                            style: TextStyle(fontFamily: 'NEXON', fontSize: 28),
                            maxLines: 1,
                          ),*/
                        ],
                      ),
                    );
                  },
              ),
            ),


            /*
            Positioned(
              top: height * 0.27,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.2,
                    child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Container(
                    width: width * 1.45,
                    child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),*/

            text(),

            /*
            Container(
                height: height*0.046,
                color: Colors.white,
              child: Row(
                mainAxisAlignment : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(12.0, 4.0, 8.0, 5.0),
                    child: Icon(
                        Icons.campaign_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                  Text(
                    '버전 1.2 출시! 어플을 업데이트 해주세요!',
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.start,
                  ),
                ],
              )
            ),*/
          ],
        ),


    );
  }

  Future<void> progressGet() async{
    progress = [];
    await FirebaseFirestore.instance.collection("Progress").doc('progress').get().then((value){
      List.from(value.data()['progress']).forEach((element){
        var data = element;
        progress.add(data);
      });
    });
  }

  Future<void> userProgressGet() async{
    await progressGet();
    //await getUserProgress();
    var _userRepository = UserRepository();
    userProgress = await _userRepository.progressGet();
    //print(userProgress);
  }

  /*
  Future<void> getUserProgress() async{
    userProgress = [];
    var count = 0;
    List _progress = progress;
    for (var i = 0; i < _progress.length; i++){ //i는 스테이지값
      count = 0;
      for(var j = 1; j < _progress[i]+1; j++){ //j는 step
        if(i == 0) { //0 스테이지
          if(UserProvider.getUser().conceptProgress["0-0"] == 2) count = 1;
        }
        else if(i % 2 == 0){ //실전 스테이지 i가 2면 1-1 == 2, 1-2 == 2
          if(UserProvider.getUser().projectProgress["${(i+1)~/2}-${j}"] == 2){
            count++;
          }
        }
        else { //개념 스테이지 i가 1이면 1-1 1-2 ~~ 1-5 == 2일때
          if(UserProvider.getUser().conceptProgress["$i-$j"] == 2){
            count++;
          }
        }
      }
      userProgress.add(count);
    }
  }
   */

  void _images(){
    images = [];
    var level = UserRepository().checkStageLock();
    stage = 17; // todo: 지금까지 나온 스테이지 개수, 나중엔 db에서 불러와야함

    for(var i = 0; i < stage*2+1; i++){
      if(i < level){ // 1과 실전을 깼으면 0과~1과 개념(index 0, 1, 2)은 done
        images.add(images_done[i]);
      }
      else if(i == level){ // 2과 개념(index 3)이 unlock
        images.add(images_unlock[i]);
      }
      else { //2과 실전(index 4)부터는 lock
        images.add(images_lock[i]);
      }
    }
    images.add('assets/images/waiting.png');
    //print(images.length);
  }

  Future<dynamic> _navigator(int index) {
    var level = UserRepository().checkStageLock();
    //level = 100;

    if (sub) {
      print(11111);
      if (index == 0) { // 0과
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    QuizStgZeroScreen(
                      stageNum: index,
                      stageName: stageNameList[index],
                    ))).then((value) => setState(() {}));
      }
      else if (index <= level) { // level*2+1 : level*(실전+개념)+0과
        if (index % 2 == 0) { // 해금 - 실전
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      QuizPtSelectScreen(
                        stageNum: (index + 1) ~/ 2,
                        stageName: stageNameList[index],
                      ))).then((value) => setState(() {}));
        } else { // 해금 - 개념
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      QuizStgSelectScreen(
                        stageNum: (index / 2).round(),
                        stageName: stageNameList[index],
                      ))).then((value) => setState(() {}));
        }
      } else { // 해금 안 된 곳일때
        return null;
      }
    } else {
      print(11);
      if (index == 0) { // 0과
        print(22);
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    QuizStgZeroScreen(
                      stageNum: index,
                      stageName: stageNameList[index],
                    ))).then((value) => setState(() {}));
      }
      else if (index <= level) { // level*2+1 : level*(실전+개념)+0과
        print(33);
        if (index < 9) {
          print(44);
          if (index % 2 == 0) { // 해금 - 실전
            print(55);
            print(level);
            return Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        QuizPtSelectScreen(
                          stageNum: (index + 1) ~/ 2,
                          stageName: stageNameList[index],
                        ))).then((value) => setState(() {}));
          } else { // 해금 - 개념
            print(66);
            print(level);
            return Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        QuizStgSelectScreen(
                          stageNum: (index / 2).round(),
                          stageName: stageNameList[index],
                        ))).then((value) => setState(() {}));
          }
        } else { // 결제
          print(77);
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SubscribeMain(),
                  fullscreenDialog: true
              )).then((value) => setState(() {}));

        }
      } else { // 해금 안 된 곳일때
        print(88);
        return null;
      }
    }
  }
}

void _json() async{
  final CollectionReference postsRef = FirebaseFirestore.instance.collection('Example');
  String data = await rootBundle.loadString('assets/json/example1.json');
  final List jsonResult = json.decode(data);
  String postID = "";

  jsonResult.forEach((element) {
    Map<String, dynamic> myMap = element;
    //postID = myMap['stage'].toString()+'-'+myMap['step'].toString()+'-'+myMap['level'].toString();
    print(myMap['problem']);
    //postsRef.doc(postID).set(myMap);
  });

}



class AccordionTransformer extends PageTransformer {
  @override
  Widget transform(Widget child, TransformInfo info) {
    var position = info.position;
    if (position < 0.0) {
      return Transform.scale(
        scale: 1 + position,
        alignment: Alignment.bottomLeft,
        child: child,
      );
    } else {
      return Transform.scale(
        scale: 1 - position,
        alignment: Alignment.topLeft,
        child: child,
      );
    }
  }
}


class ScrollingText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Axis scrollAxis;
  final double ratioOfBlankToScreen;

  ScrollingText({
    @required this.text,
    this.textStyle,
    this.scrollAxis: Axis.horizontal,
    this.ratioOfBlankToScreen: 0.25,
  }) : assert(text != null,);

  @override
  State<StatefulWidget> createState() {
    return ScrollingTextState();
  }
}

class ScrollingTextState extends State<ScrollingText>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  double screenWidth;
  double screenHeight;
  double position = 0.0;
  Timer timer;
  final double _moveDistance = 3.0;
  final int _timerRest = 100;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  void startTimer() {
    if (_key.currentContext != null) {
      double widgetWidth =
          _key.currentContext.findRenderObject().paintBounds.size.width;
      double widgetHeight =
          _key.currentContext.findRenderObject().paintBounds.size.height;

      timer = Timer.periodic(Duration(milliseconds: _timerRest), (timer) {
        double maxScrollExtent = scrollController.position.maxScrollExtent;
        double pixels = scrollController.position.pixels;
        if (pixels + _moveDistance >= maxScrollExtent) {
          if (widget.scrollAxis == Axis.horizontal) {
            position = (maxScrollExtent -
                screenWidth * widget.ratioOfBlankToScreen +
                widgetWidth) /
                2 -
                widgetWidth +
                pixels -
                maxScrollExtent;
          } else {
            position = (maxScrollExtent -
                screenHeight * widget.ratioOfBlankToScreen +
                widgetHeight) /
                2 -
                widgetHeight +
                pixels -
                maxScrollExtent;
          }
          scrollController.jumpTo(position);
        }
        position += _moveDistance;
        scrollController.animateTo(position,
            duration: Duration(milliseconds: _timerRest), curve: Curves.linear);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  Widget getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      String newString = widget.text.split("").join("\n");
      return Center(
        child: Text(
          newString,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Center(
        child: Text(
          widget.text,
          style: widget.textStyle,
        ));
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return Container(width: screenWidth * widget.ratioOfBlankToScreen);
    } else {
      return Container(height: screenHeight * widget.ratioOfBlankToScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      key: _key,
      scrollDirection: widget.scrollAxis,
      controller: scrollController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        getBothEndsChild(),
        getCenterChild(),
        getBothEndsChild(),
      ],
    );
  }
}