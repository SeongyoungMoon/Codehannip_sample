import 'package:code_hannip/ui/home/bottombar.dart';
import 'package:code_hannip/ui/home/home.dart';
import 'package:code_hannip/ui/project/camera_main_screen.dart';
import 'package:code_hannip/ui/project/camera_result_screen.dart';
import 'package:code_hannip/ui/themecoding/themecoding_main_screen.dart';
import 'package:flutter/material.dart';

import 'ui/auth/register_screen.dart';
import 'ui/auth/sign_in_screen.dart';
import 'ui/quiz/quiz_main_screen.dart';
import 'ui/setting/setting_screen.dart';
import 'ui/splash/splash_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String quizMain = '/quizMain';
  static const String movingMain = '/movingMain';
  static const String setting = '/setting';
  static const String cameraResult = '/cameraResult';
  static const String themeMain = '/themeMain';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => SignInScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => HomeScreen(),
    setting: (BuildContext context) => SettingScreen(),
    //quizMain: (BuildContext context) => QuizMainScreen(),
    quizMain: (BuildContext context) => BottomBarMainScreen(0),
    movingMain: (BuildContext context) => CameraMainScreen(),
    cameraResult: (BuildContext context) => LogicResultScreen(),
    themeMain: (BuildContext context) => BottomBarMainScreen(1), //테마로 가도록 바꿔야 함
  };
}
