import 'package:auto_size_text/auto_size_text.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/home/bottombar.dart';
import 'package:code_hannip/ui/project/camera_pt_select_screen.dart';
import 'package:code_hannip/ui/quiz/quiz_pt_select_screen.dart';
import 'package:code_hannip/ui/quiz_stage_zero/quiz_stgZero_screen.dart';
import 'package:code_hannip/ui/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';


class CameraMainScreen extends StatefulWidget {
  @override
  _CameraMainScreenState createState() => _CameraMainScreenState();
}

class _CameraMainScreenState extends State<CameraMainScreen> {
  /*
  List<String> stageNameList = [
    "프로그래밍의 이해",
    "자료형 개념",
    "자료형 응용",
    "변수 개념",
    "변수 응용",
    "입출력 개념",
    "입출력 응용",
  ];

  List<String> images = [

  ];*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            '무빙 코딩',
            textAlign : TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          /*
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomBarMainScreen()),
              );
            },
          ),*/
        ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Image.asset(
                  'assets/images/0.png',
                  fit: BoxFit.contain,
                  width: 350,
                  height: 350,
                ),
                onTap: () {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CameraQuizPtSelectScreen(
                                stageNum: 10, //movingforkids
                                stageName: "무빙코딩",
                              ))).then((value) => setState(() {}));
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              Text(
                'STAGE 1',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 6.0),
              Text(
                'if문 응용',
                style: TextStyle(fontFamily: 'NEXON', fontSize: 28),
                maxLines: 1,
              )
            ],
          ),
        ),
      ),


    );
  }
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
