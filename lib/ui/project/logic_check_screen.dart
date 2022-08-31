import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:code_hannip/models/coding_card_model.dart';
import 'package:code_hannip/models/record_model.dart';
import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/data_repository/project_repository.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/ui/project/result_screen.dart';
import 'package:code_hannip/widgets/answer_dialog.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:code_hannip/widgets/flip_card.dart';
import 'package:code_hannip/widgets/rank_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LogicCheckScreen extends StatefulWidget {
  @override
  _LogicCheckScreenState createState() => _LogicCheckScreenState();
}

class _LogicCheckScreenState extends State<LogicCheckScreen> {
  bool isSuccessful = false;

  var cardLists = [];
  List<List<List<String>>> check = [];
  var type = '';
  var value = '';

  ProjectProvider projectProvider;

  @override
  void initState() {
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    projectProvider.projectModel.cocaList.entries.forEach((element) {
      for (var value in element.value) {
        cardLists.add(CodingCardModel(type: element.key, value: '$value'));
      }
    });
    var i = 0;
    projectProvider.projectModel.answerList.entries.forEach((element) {
      check.add([]);
      element.value.forEach((e) => check[i].add(null));
      i++;
    });
    cardLists..shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
        transform:  Matrix4.translationValues(10.0, 0.0, 0.0),
          child: Text(
            projectProvider.projectModel.title,
            style: Theme
                .of(context)
                .textTheme
                .displayMedium,
          ),
        ),
        actions: [
          //timer part
          Container(
              decoration: BoxDecoration(
                  //border: Border.all(color: Color(0xFFC4C4C4)),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Icon(Icons.timer, size: 21)
                    ),
                    SizedBox(
                      width: phoneSize.width * 0.01,
                    ),
                    ProjectTimer(),
                  ],
                ),
              )),
          /*IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  cardLists.clear();
                  projectProvider.projectModel.cocaList.entries
                      .forEach((element) {
                    for (var value in element.value) {
                      cardLists.add(
                          CodingCardModel(type: element.key, value: value));
                    }
                  });
                  cardLists..shuffle();
                  check = [];
                  var i = 0;
                  projectProvider.projectModel.answerList.entries
                      .forEach((element) {
                    check.add([]);
                    element.value.forEach((e) => check[i].add(null));
                    i++;
                  });
                });
              })*/
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                    Container(
                      width: phoneSize.width * 0.6,
                      child: AutoSizeText(
                        projectProvider.projectModel.problem,
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 3,
                      ),
                    ),
                     */
                    Container(
                      child: Text(
                        '로직 순서',
                        style: Theme.of(context).textTheme.displayLarge
                      ),
                    ),

                    Container(
                      child: TextButton.icon(
                        onPressed: () {
                          //문제 팝업창 띄우기
                          showDialog(
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('메인 문제 확인',
                                  style: Theme.of(context).textTheme.displayLarge,
                                  textAlign: TextAlign.center,
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(projectProvider.projectModel.problem,
                                      style: Theme.of(context).textTheme.titleMedium
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('문제로 돌아가기'),
                                  ),
                                ],
                              );
                            },
                              context: context
                          );
                        },
                        label: Text(
                          '메인 문제 보기',
                        ),
                        icon: Icon(Icons.help_outline, size: 20),


                      )
                    )

                  ],
                ),
                // SizedBox(height: 4.0),
                logicOrder(projectProvider.projectModel.logicList, phoneSize),
                SizedBox(
                  height: phoneSize.height * 0.02,
                ),
                Container(
                  height: phoneSize.height *
                      projectProvider.projectModel.answerList.length *0.1,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: projectProvider.projectModel.answerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var split =
                          projectProvider.projectModel.answerList[index];
                      return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(split.length, (i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                child: dragTarget(index, i, phoneSize),
                              );
                            }),
                          ));
                    },
                  ),
                ),
                Divider(height: 1.0,),
                SizedBox(
                  height: phoneSize.height * 0.02,
                ),
                Wrap(
                  children: cardLists
                      .map((e) => draggableFlippingCoCa(e.type, e.value))
                      .toList(),
                ),
                cardLists.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 36.0),
                        child: ExtendedFAB(
                          icon: Icons.check,
                          title: '정답 확인',
                          function: fabFunction,
                        ),
                      )
                    : Padding(
                  padding: EdgeInsets.only(top: 36.0),
                  child: ExtendedFAB(
                    icon: Icons.replay,
                    title: '카드 되돌리기',
                    function: fabFunction2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dragTarget(int index, int i, Size phoneSize) {
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        return Center(
          child: check[index][i] != null
              ? FlipCodingCard(
                  type: check[index][i][0], value: check[index][i][1])
              : Container(
                  width: phoneSize.width * 0.18,
                  height: phoneSize.height * 0.06,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.all(
                      Radius.circular(5))
                ),
        )
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        var split = data.toString().split(' ');
        type = split.first;
        value = split.last;

        setState(() {
          check[index][i] = [type, value];
          cardLists.removeAt(
              cardLists.indexWhere((element) => element.value == value));
        });
      },
    );
  }

  Future<void> fabFunction() async {
    var userAnswerList = check
        .map((e) => List.generate(e.length, (index) => e[index][1]).join(' '))
        .toList();
    var answerList = projectProvider.projectModel.answerList.entries
        .map((e) => e.value.join(' '))
        .toList();

    Function eq = const ListEquality().equals;

    eq(userAnswerList, answerList)
        ? await rankingDialog()
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AnswerDialog(
                isCorrect: false,
              );
            });
  }

  Future<void> fabFunction2() async {
    setState(() {
      cardLists.clear();
      projectProvider.projectModel.cocaList.entries
          .forEach((element) {
        for (var value in element.value) {
          cardLists.add(
              CodingCardModel(type: element.key, value: value));
        }
      });
      cardLists..shuffle();
      check = [];
      var i = 0;
      projectProvider.projectModel.answerList.entries
          .forEach((element) {
        check.add([]);
        element.value.forEach((e) => check[i].add(null));
        i++;
      });
    });
  }

  Future<void> rankingDialog() async {
    var userRepository = UserRepository();
    var projectRepository = ProjectRepository();

    var rankList = projectProvider.projectModel.rankList;
    var name = UserProvider.getUser().name;
    var record = projectProvider.record;

    if (UserProvider.getUser().phoneNum == '0100000000') {
      print("no");
    }
    else{
      var sameIndex = rankList.indexWhere((element) => element.name == name);

      // 기존 랭킹 리스트에서 현재 사용자 이름으로 기록이 존재하면,
      if (sameIndex != -1 && rankList[sameIndex].record >= record) {
        rankList.removeAt(sameIndex);
        rankList.add(RecordModel(name: name, record: record));

        await userRepository.updateUserRecord(projectProvider.projNum, record);
        // 기존 랭킹 리스트에 현재 사용자 이름이 없을 때,
      } else if (sameIndex == -1) {
        rankList.add(RecordModel(name: name, record: record));
        await userRepository.updateUserRecord(projectProvider.projNum, record);
      }
      rankList.sort((b, a) => b.record.compareTo(a.record));
      await projectRepository.updateProjectRecords(
          projectProvider.projectModel, rankList);
    }

    var progressNum = projectProvider.projectModel.stageNum.toString()
                        +"-"+projectProvider.projectModel.stepNum.toString();//ex) 1-1, 5-4, .. (stageNum-stepNum)

    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return RankDialog(
            name: name,
            record: record,
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                        value: projectProvider, child: ResultScreen(progressNum)))),
            rankList: rankList,
          );
        });
  }

  Widget draggableFlippingCoCa(String type, String value) {
    return Draggable<String>(
      data: '$type $value',
      child: FlipCodingCard(
        type: type,
        value: value,
      ),
      feedback: FlipCodingCard(
        type: type,
        value: value,
      ),
      childWhenDragging: Container(),
    );
  }

  Widget logicOrder(List<dynamic> strList, Size phoneSize) {
    return Container(
      width: phoneSize.width * 0.9,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(strList.length, (index) {
              return Text('${index + 1}. ${strList[index].toString()}',
                  style: Theme.of(context).textTheme.titleMedium);
            })),
      ),
    );
  }
}

class ProjectTimer extends StatefulWidget {
  @override
  _ProjectTimerState createState() => _ProjectTimerState();
}

class _ProjectTimerState extends State<ProjectTimer> {
  Timer _timer;

  ProjectProvider projectProvider;

  @override
  void initState() {
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      projectProvider.updateRecord();
    });
    super.initState();
  }

  @override
  void dispose() {
    projectProvider.clearRecord();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (_, projectProvider, __) {
        var sec = projectProvider.record % 60;
        var f = NumberFormat("00");

        return Text(
          '${f.format(Duration(seconds: projectProvider.record).inMinutes)}:${f.format(sec)}',
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
