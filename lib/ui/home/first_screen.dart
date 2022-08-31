import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/quiz/quiz_main_screen.dart';
import 'package:code_hannip/ui/tutorial/ai_tutorial_screen.dart';
import 'package:code_hannip/ui/tutorial/card_tutorial_screen.dart';
import 'package:flutter/material.dart';

import '../setting/setting_screen.dart';
import 'bottombar.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: UserProvider.getUser() == null
            ? Text(
                "회원님, 반갑습니다!",
                style: Theme.of(context).textTheme.headline6,
              )
            : Text(
                "${UserProvider.getUser().nickname} 님, 반갑습니다!",
                style: Theme.of(context).textTheme.headline6,
              ),
        leading: Container(),
        actions: [
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
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              _box(
                  context,
                  "터치 코딩",
                  "코딩의 개념을 스스로 공부하고 코딩카드를 터치해서 문제를 풀며 실력을 높일 수 있습니다.",
                  "assets/images/sophiaAlone.png", () {
                UserProvider.touchCodingSelected();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UserProvider.getUser().skipTuto[0]
                                //? QuizMainScreen()
                                ? BottomBarMainScreen(0)
                                : CardTutorialScreen()));
              }),
              SizedBox(height: 16.0),
              _box(
                  context,
                  "무빙 코딩",
                  "실제 코딩카드를 움직이면서 실전 프로젝트를 코딩하고 카메라를 통해 인식하여 문제를 해결합니다.",
                  "assets/images/sophiaTogether.png", () {
                UserProvider.movingCodingSelected();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UserProvider.getUser().skipTuto[1]
                                //? QuizMainScreen()
                                ? BottomBarMainScreen(1)
                                : AiTutorialScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box(BuildContext context, String t1, String t2, String imageText,
      Function f) {
    return Container(
      height: 240.0,
      child: FlatButton(
        onPressed: f,
        child: Container(
          padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                imageText,
                fit: BoxFit.contain,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t1,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    t2,
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
