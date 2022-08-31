import 'package:code_hannip/models/user_model.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:flutter/material.dart';

import '../caches/sharedpref/shared_preference_helper.dart';

class UserProvider extends ChangeNotifier {
  static final UserRepository _userRepository = UserRepository();

  static UserModel _user;
  static bool _isTouchCoding = true;

  UserModel get user => _user;

  //List<dynamic> userProgressed;

  // shared pref object
  SharedPreferenceHelper _sharedPrefsHelper;

  UserProvider() {
//    _userStatus = AuthProvider().auth.currentUser != null
//        ? UserStatus.LoggedIn
//        : UserStatus.Init;
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  static UserModel getUser() {
    return _user;
  }

  static void setAnonymouseUser(UserModel user) async {
    _user = user;
  }

  static void setUser(String uid) async {
    _user = await _userRepository.getUserFromUid(uid);
    print("셋유저 지금 토큰 업뎃 ");
  }

  static void updateUser(String uid) async {
    print(44444444);
    _user = await _userRepository.getUserFromUid(uid);
    print("업데이트 유저 지금 토큰 업뎃");

    ///token update
  }

  static Future<List> getProgressed() async {
    return _userRepository.progressGet();
  }

  static bool isTouchCoding() => _isTouchCoding;

  static void touchCodingSelected() => _isTouchCoding = true;
  static void movingCodingSelected() => _isTouchCoding = false;
}
