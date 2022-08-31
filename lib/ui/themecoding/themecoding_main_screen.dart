import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/quiz/quiz_main_screen.dart';
import 'package:code_hannip/ui/quiz/quiz_pt_select_screen.dart';
import 'package:code_hannip/ui/quiz_stage_zero/quiz_stgZero_screen.dart';
import 'package:code_hannip/ui/setting/setting_screen.dart';
import 'package:code_hannip/ui/subscribe/subscribe_main.dart';
import 'package:code_hannip/ui/themecoding/theme_pt_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/ui/quiz/quiz_stg_select_screen.dart';

class ThemeMainScreen extends StatefulWidget {

  @override
  _ThemeMainScreenState createState() => _ThemeMainScreenState();
}

class _ThemeMainScreenState extends State<ThemeMainScreen> {

  var stage = 5; // todo: 지금까지 나온 스테이지 개수, 나중엔 db에서 불러와야함
  bool sub = false; // subscripted or not


  List<int> stageCount = [
    1
  ];

  List<int> themeProblems =[
    4, 14, 22, 30, 38, 48
  ]; //badge

  List<String> stageNameList = [
    "나머지 계산하기",
    "계산기 만들기",
    "구구단 만들기",
    "이름 고치기",
    "코드한입 찾기",
    "당첨번호 뽑기",
    "점수 계산하기",
    "평균 키 구하기",
    "개봉일 정렬하기",
  ];

  List<String> images_unlock = [
    'assets/images/theme01.png',
    'assets/images/theme02.png',
    'assets/images/theme03.png',
    'assets/images/theme04.png',
    'assets/images/theme05.png',
    'assets/images/theme06.png',
    'assets/images/theme07.png',
    'assets/images/theme08.png',
    'assets/images/theme09.png',
  ];

  List<String> images_lock = [
    'assets/images/Tstage1L.png',
    'assets/images/Tstage2L.png',
    'assets/images/Tstage3L.png',
    'assets/images/theme04L.png',
    'assets/images/theme05L.png',
    'assets/images/theme06L.png',
    'assets/images/theme07L.png',
    'assets/images/theme08L.png',
    'assets/images/theme09L.png',
  ];

  List<String> images_done = [
    'assets/images/theme01D.png',
    'assets/images/theme02D.png',
    'assets/images/theme03D.png',
    'assets/images/theme04D.png',
    'assets/images/theme05D.png',
    'assets/images/theme06D.png',
    'assets/images/theme07D.png',
    'assets/images/theme08D.png',
    'assets/images/theme09D.png',

  ];

  List<String> images = [];

  List progress = [];
  List userProgress = [];

  var clearCount = UserRepository().theme_clear2();

  @override
  void initState() {
    super.initState();
    userProgressGet();
    var provider = Provider.of<ProviderModel>(context, listen: false);
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

    //todo: userprogress값 계속 파베에서 불러와야돼
    _images();
    var level = UserRepository().theme_clear2();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '테마 코딩',
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
                image: AssetImage("assets/images/themeBackground.png"),
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
                          //clearCount == themeProblems[index]+2 ?
                          //images_done[index]:images_unlock[index],
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
    var level = UserRepository().theme_clear2();
    print("테마코딩 level");
    print(level);
    stage = 8; // todo: 지금까지 나온 스테이지 개수, 나중엔 db에서 불러와야함

    for(var i = 0; i < stage+1; i++){
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
    //images.add('assets/images/waiting.png');
    //print(images.length);
  }

  Future<dynamic> _navigator(int index) {
    var level = UserRepository().theme_clear2();
    //level = 100;

    /*
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ThemePtSelectScreen(
                  stageNum: index,
                  stageName: stageNameList[index],
                ))).then((value) => setState(() {}));
     */
    if(index <= level){
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  ThemePtSelectScreen(
                    stageNum: index,
                    stageName: stageNameList[index],
                  ))).then((value) => setState(() {}));
    } else { // 해금 안 된 곳일때
      return null;
    }

    /*
    if (sub) {
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
                      ThemePtSelectScreen(
                        stageNum: (index + 1) ~/ 2,
                        stageName: stageNameList[index],
                      ))).then((value) => setState(() {}));
        } else { // 해금 - 개념
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ThemeStgSelectScreen(
                        stageNum: (index / 2).round(),
                        stageName: stageNameList[index],
                      ))).then((value) => setState(() {}));
        }
      } else { // 해금 안 된 곳일때
        return null;
      }
    } else {
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
        if (index < 5) {
          if (index % 2 == 0) { // 해금 - 실전
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
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SubscribeMain(),
                  fullscreenDialog: true
              )).then((value) => setState(() {}));

        }
      } else { // 해금 안 된 곳일때
        return null;
      }
    }*/
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
