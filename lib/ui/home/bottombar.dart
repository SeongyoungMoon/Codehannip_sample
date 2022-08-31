import 'package:auto_size_text/auto_size_text.dart';
import 'package:code_hannip/constants/app_font_family.dart';
import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/project/camera_main_screen.dart';
import 'package:code_hannip/ui/quiz/quiz_main_screen.dart';
import 'package:code_hannip/ui/quiz/quiz_pt_select_screen.dart';
import 'package:code_hannip/ui/quiz_stage_zero/quiz_stgZero_screen.dart';
import 'package:code_hannip/ui/relayquiz/relay_quiz_main_screen.dart';
import 'package:code_hannip/ui/setting/setting_screen.dart';
import 'package:code_hannip/ui/themecoding/themecoding_main_screen.dart';
import 'package:code_hannip/ui/tutorial/ai_tutorial_screen.dart';
import 'package:code_hannip/ui/tutorial/card_tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class BottomBarMainScreen extends StatefulWidget {
  final int current;

  BottomBarMainScreen(this.current);
  @override
  _BottomBarMainScreenState createState() => _BottomBarMainScreenState();
}

class _BottomBarMainScreenState extends State<BottomBarMainScreen> {

  int _currentIndex = 0;

  @override
  initState(){
    super.initState();
    _currentIndex = widget.current;
  }

  final List<Widget> _children = [
    UserProvider.getUser().skipTuto[0]
        ? QuizMainScreen()
        : CardTutorialScreen(),

    UserProvider.getUser().skipTuto[1]
      ? ThemeMainScreen()
      : AiTutorialScreen(),


    //ThemeMainScreen(),

    //RelayQuizMainScreen(),

    SettingScreen(),

  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        UserProvider.touchCodingSelected();
        UserProvider.getProgressed();
      }
      else if (index == 1) {
        UserProvider.movingCodingSelected();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context); // todo: when we use provider??
    // TODO: implement build
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 100,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: '터치 코딩',
          ),
          BottomNavigationBarItem(
            //icon: ImageIcon(AssetImage('assets/images/movingcoding.png')),
            icon: Icon(Icons.content_paste),
            label: '테마 코딩',
          ),
          /*
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/quiz.png')),
            label: '릴레이 퀴즈',
          ),
          */
          BottomNavigationBarItem(
            icon: Icon(
                Icons.person_outline,
            ),
            label: '마이페이지',
          ),
        ],
        currentIndex: _currentIndex,
        //selectedItemColor: Color(0xffEF5350),
        fixedColor: Theme.of(context).colorScheme.primary,
        selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700),
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.secondary
        ),
        showUnselectedLabels: true,
        onTap: _onTap,
      ),
    );
  }
  
}