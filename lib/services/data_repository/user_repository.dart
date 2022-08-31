import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_hannip/models/user_model.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:flutter/material.dart';

import '../firestore_path.dart';
import '../firestore_service.dart';

class UserRepository {
  final _firestoreService = FirestoreService.instance;


  // 터치 코딩 or 무빙 코딩, 튜토리얼 완료 여부 업데이트 하는 함수
  Future<void> updateTutoList(int tutoNum) async {
    var userModel = UserProvider.getUser();
    userModel.skipTuto[tutoNum] = true;
    await _firestoreService.setData(
      path: FirestorePath.user(userModel.uid),
      data: userModel.toMap(),
      merge: true,
    );
  }

/*
  Future<void> updateProgress(int stepNum) async {
    var userModel = UserProvider.getUser();
    userModel.stageProgress[stepNum] += 1;
    await _firestoreService.setData(
      path: FirestorePath.user(userModel.uid),
      data: userModel.toMap(),
      merge: true,
    );
  }

 */

  Future<List> progressGet() async{
    var progress = [];
    await FirebaseFirestore.instance.collection("Progress").doc('progress').get().then((value){
      List.from(value.data()['progress']).forEach((element){
        var data = element;
        progress.add(data);
      });
    });

    var userprogress = await getUserProgress(progress);

    return userprogress;
  }

  Future<List> getUserProgress(List progress) async{
    var userProgress = [];
    var count = 0;
    var _progress = progress;
    for (var i = 0; i < _progress.length; i++){ //i는 스테이지값
      count = 0;
      for(var j = 1; j < _progress[i]+1; j++){ //j는 step
        if(i == 0) { //0 스테이지
          //if(UserProvider.getUser().conceptProgress["0-0"] == 2) count = 1;
          count = 1;
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
    return userProgress;
  }

  // 유저별 '스테이지-프로젝트'에 해당하는 코딩짜기 결과 시간 업데이트 해주는 함수
  // 해당 프로젝트의 지금까지 결과중 가장 성적이 좋은 결과만 저장
  Future<void> updateUserRecord(String projNum, int time) async {
    var user = UserProvider.getUser().copyWith(
        projectRecords: UserProvider.getUser().projectRecords
          ..[projNum] = time);
    await _firestoreService.setData(
      path: FirestorePath.user(UserProvider.getUser().uid),
      data: user.toMap(),
    );
    UserProvider.setUser(user.uid);
    print("여기가 진짜 유저 타이머 업데이트");
  }

  //유저별 '스테이지-컨셉트'에 해당하는 진행도 결과 업데이트해주는 함수
  //이 함수로 badge그림이 바뀜
  Future<void> updateConceptProgress(String conceptNum, int progress) async {
    var user = UserProvider.getUser().copyWith(
        conceptProgress: UserProvider.getUser().conceptProgress
          ..[conceptNum] = progress);
    await _firestoreService.setData(
      path: FirestorePath.user(UserProvider.getUser().uid),
      data: user.toMap(),
    );
    UserProvider.setUser(user.uid);
  }

  //유저별 '스테이지-프로젝'에 해당하는 진행도 결과 업데이트해주는 함수
  //이 함수로 badge그림이 바뀜
  Future<void> updateProjectProgress(String projNum, int progress) async {
    var user = UserProvider.getUser().copyWith(
        projectProgress: UserProvider.getUser().projectProgress
          ..[projNum] = progress);
    await _firestoreService.setData(
      path: FirestorePath.user(UserProvider.getUser().uid),
      data: user.toMap(),
    );
    UserProvider.setUser(user.uid);
  }

  //유저별 '스테이지-테마'에 해당하는 진행도 결과 업데이트해주는 함수
  //이 함수로 badge그림이 바뀜
  Future<void> updateThemeProgress(String projNum, int progress) async {
    var user = UserProvider.getUser().copyWith(
        themeProgress: UserProvider.getUser().themeProgress
          ..[projNum] = progress);
    await _firestoreService.setData(
      path: FirestorePath.user(UserProvider.getUser().uid),
      data: user.toMap(),
    );
    UserProvider.setUser(user.uid);
  }

  //유저가 어디까지 잠금해제했는지를 뱃지 개수 합으로 계산해서 알려주는 함수
  //뱃지 개수 합이 일정 이상으로 넘어가면 다음 스테이지 해제해야함
  int checkStageLock() {
    var badgeNum = 0; // badge 개수
    var conceptLock = UserProvider.getUser().copyWith(
        conceptProgress: UserProvider.getUser().conceptProgress).conceptProgress.values.toList(); // concept 해금상태
    var projectLock = UserProvider.getUser().copyWith(
        projectProgress: UserProvider.getUser().projectProgress).projectProgress.values.toList(); // project 해금상태

    for(var i = 0; i < conceptLock.length; i++){
      badgeNum += conceptLock[i];
    }
    for(var i = 0; i < projectLock.length; i++){
      badgeNum += projectLock[i];
    }
    print(badgeNum);

    //0과: 1개
    //1과: 5+3개 sum: 9
    //2과: 2+3개 sum: 14
    //3과: 2+3개 sum: 19

    return cal_level(badgeNum);
  }

  int cal_level(int level){
    List<int> problemNum;
    problemNum = [1, //0과
                  4, 4, 2, 5, 2, 5, 3, 5, 3, 4, //1~5과
                  3, 6, 2, 4, 4, 5, 4, 4, 3, 5, //6~10과
                  4, 5, 3, 4, 3, 4, 4, 6, 5, 6,//11~15과
                  3, 6, 3, 5, 2, 4, 3, 6,// 16~19과
                  0]; //마지막

    // 각 stage당 step 수(0과, 1과연습, 1과실전, 2과연습, ...)

    var _level = 0; //0과도 안풀었을때
    //print(problemNum.length);
    for (var i = 1; i < problemNum.length; i++){
      if(level >= cal_problemNum(problemNum, i) * 2) _level = i; // 금뱃지 값이 2라서 problemNum[i] * 2 해줌
    }
    //print("level");
    //print(_level);
    return _level;
  }

  int cal_problemNum(List problemNum, var i){
    ///i번째 stage까지의 소단원(카드위젯) 개수 총합
    var sum = 0;
    for (var j = 0; j < i; j++){
      sum += problemNum[j];
    }
    //print("sum");
    //print(sum);
    return sum;
  }

  //테마코딩 단원당 문제 다 풀었는지 check (총 풀었는 badge 수 다 합친 값 return)
  int theme_clear(){
    var badgeSum = 0; // badge 개수
    var themeBadge = UserProvider.getUser().copyWith(
        themeProgress: UserProvider.getUser().themeProgress).themeProgress.values.toList(); // concept 해금상태

    for(var i = 0; i < themeBadge.length; i++){
      badgeSum += themeBadge[i];
    }
    print(badgeSum);

    return badgeSum;
  }

  int theme_clear2(){
    var badgeSum = 0; // badge 개수
    var themeBadge = UserProvider.getUser().copyWith(
        themeProgress: UserProvider.getUser().themeProgress).themeProgress.values.toList(); // concept 해금상태

    for(var i = 0; i < themeBadge.length; i++){
      badgeSum += themeBadge[i];
    }
    //print("여기서 badgeSum");
    //print(badgeSum);

    return theme_level(badgeSum);
  }

  int theme_level(int level){
    List<int> problemNum;
    problemNum = [0, 3, 5, 4, 4, 4, //5stage
      5, 4, 5, 5, 0];

    var _level = 0; //0과도 안풀었을때
    print(problemNum.length);
    for (var i = 1; i < problemNum.length; i++){
      if(level >= theme_problemNum(problemNum, i) * 2)
        _level = i-1; // 금뱃지 값이 2라서 problemNum[i] * 2 해줌
    }
    //print("level");
    //print(_level);
    return _level;
  }

  int theme_problemNum(List problemNum, var i){
    var sum = 0;
    for (var j = 0; j < i; j++){
      sum += problemNum[j];
    }
    //print("sum");
    //print(sum);
    return sum;
  }

  bool isSame(int index) {
    List<int> themeProblems;
    themeProblems =[
      4, 14, 22, 30, 38, 48, 56, 66, 76
    ];
    var clearCount;
    clearCount = UserRepository().theme_clear();
    if(clearCount >= themeProblems[index]){
      return true;
    }
    else{
      return false;
    }
  }

  Color ableOrdisable(int index){
    bool canAble;
    canAble = UserRepository().isSame(index);
    if(canAble){
      return Colors.deepOrange;
    }
    else{
      return Colors.black26;
    }
  }


  Future<UserModel> getUserFromUid(String uid) async {
    var aaa = await _firestoreService.getData(path: FirestorePath.user(uid));
    print(aaa.exists);
    print(aaa.data());
    print(aaa.metadata);
    var CUser = UserModel.fromDs(
        await _firestoreService.getData(path: FirestorePath.user(uid)));

    return CUser;
  }
}
