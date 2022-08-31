import 'package:code_hannip/models/user_model.dart';

class UserUtil {
  static UserModel _user;
  static bool _isTouchCoding = true;

  static void setUser(UserModel user) async {
    _user = user;
  }

  static UserModel getUser() => _user;
  static bool isTouchCoding() => _isTouchCoding;

  static void touchCodingSelected() => _isTouchCoding = true;
  static void movingCodingSelected() => _isTouchCoding = false;
}
