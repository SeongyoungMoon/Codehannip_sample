import 'package:code_hannip/models/example_model.dart';
import 'package:flutter/material.dart';

import '../caches/sharedpref/shared_preference_helper.dart';

class ExampleProvider extends ChangeNotifier {
  // shared pref object
  SharedPreferenceHelper _sharedPrefsHelper;
  List<ExampleModel> _exampleList = [];
  final List<dynamic> _choiceList = [];
  int _currentLevel = 0;

  ExampleProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  List get exampleList => _exampleList;

  int get currentLevel {
    _sharedPrefsHelper.currentLevel.then((value) {
      if (value != null) {
        _currentLevel = value;
      }
    });

    return _currentLevel;
  }

  List loadExampleList(List<ExampleModel> list) {
    list.sort();
    _exampleList = list;
    notifyListeners();
    return _exampleList;
  }

  List changeChoice(int pick) {
    _choiceList.forEach((element) {
      element = false;
    });

    _choiceList[pick] = true;

    notifyListeners();

    return _choiceList;
  }

  void upLevel(int level) {
    _currentLevel = level + 1;

    _sharedPrefsHelper.changeLevel(_currentLevel);
    notifyListeners();
  }

  void resetLevel() {
    _sharedPrefsHelper.changeLevel(0);
    notifyListeners();
  }

  void updateLevel(int level) {
    _currentLevel = level;

    _sharedPrefsHelper.changeLevel(_currentLevel);
    notifyListeners();
  }
}
