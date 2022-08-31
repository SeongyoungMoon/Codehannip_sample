//import 'package:code_hannip/models/project_model.dart';
import 'package:code_hannip/models/theme_model.dart';
import 'package:flutter/material.dart';

class ThemeCodingProvider extends ChangeNotifier {
  ThemeModel themeModel;
  final List<dynamic> _selectedLogicList = [];
  int _record = 0;
  String _projNum;

  ThemeModel get projectModel => themeModel;
  List get selectedLogicList => _selectedLogicList;
  int get record => _record;
  String get projNum => _projNum;

  void loadSelectedLogicList(
      ThemeModel projectModel, List list, String projNum) {
    themeModel = projectModel;
    _selectedLogicList.addAll(list);
    _selectedLogicList.shuffle();
    _projNum = projNum;
    notifyListeners();
  }

  void updateSelectedLogicList(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final items = _selectedLogicList.removeAt(oldIndex);
    _selectedLogicList.insert(newIndex, items);
    notifyListeners();
  }

  void updateRecord() {
    _record++;
    notifyListeners();
  }

  void clearRecord(){
    _record = 0;
  }

}