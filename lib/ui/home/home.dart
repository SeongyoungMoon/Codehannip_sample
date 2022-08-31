import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/home/bottombar.dart';
import 'package:flutter/material.dart';

import 'first_screen.dart';
import 'nickname_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _user = UserProvider.getUser();
    print(3333);
    if (_user.nickname.isEmpty) {
      return NicknameScreen();
    } else {
      //return FirstScreen();
      return BottomBarMainScreen(0);
    }
  }
}
