import 'package:code_hannip/models/project_model.dart';
import 'package:code_hannip/models/theme_model.dart';
import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/providers/theme_coding_provider.dart';
import 'package:code_hannip/providers/theme_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/data_repository/project_repository.dart';
import 'package:code_hannip/services/data_repository/theme_repository.dart';
import 'package:code_hannip/ui/project/logic_design_screen.dart';
import 'package:code_hannip/ui/themecoding/theme_logic_screen.dart';
import 'package:code_hannip/widgets/answer_dialog.dart';
import 'package:code_hannip/widgets/expanded_fab2.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:code_hannip/widgets/quiz_practice_card.dart';
import 'package:code_hannip/widgets/theme_quiz_practice_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ThemePtSelectScreen extends StatelessWidget {
  final int stageNum;
  final String stageName;

  const ThemePtSelectScreen({Key key, this.stageNum, this.stageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var projectRepository = ThemeRepository();

    ProjectProvider projectProvider;


    var realStageNum = stageNum + 1; //Appbar 에 표시되는 Stage 숫자

    var clearCardNum = 0; //임의로 만든 몇 개의 STEP 을 클리어했는지 확인해주는 변수

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0.0,
          title: Transform(
          transform:  Matrix4.translationValues(10.0, 0.0, 0.0),
            child: Text(
            "$stageName",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          ),
          ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: Column(
          children: [
            Expanded(child: stepCard(clearCardNum)),
          ],
        )
    );
  }


  Future<void> fabFunction() async {
    return AnswerDialog(
      isCorrect: false,
    );
  }

  Widget stepCard(var clearCardNum){
    var projectRepository = ThemeRepository();
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: StreamBuilder<List<ThemeModel>>(
            stream: projectRepository.loadProjects(stageNum),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                var _projectList = snapshot.data;
                return ListView.separated(
                  itemCount: _projectList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    //마지막 결과 보기가 아니라면
                    if(_projectList[index].lastProblem == false){
                      //첫번째 (index 0) 이라면
                      if(_projectList[index].first == true){
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.background),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("PROJECT GOAL",
                                  style: Theme.of(context).textTheme.headlineMedium),
                              SizedBox(height: 8.0),
                              Text(_projectList[index].description,
                                  style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        );
                      }
                      return ThemeQuizPracticeCard(
                        progressNum: '$stageNum-${index}',
                        levelTime: _timeConverter(index),
                        projectNum: 'STEP ${index}',
                        titleText:
                        "${_projectList[index].title}",
                        contentText: _projectList[index].description,
                        practicePage: ChangeNotifierProvider<ThemeCodingProvider>.value(
                            value: ThemeCodingProvider()
                              ..loadSelectedLogicList(
                                  _projectList[index],
                                  _projectList[index].logicList,
                                  '${_projectList[index]
                                      .stageNum}-${_projectList[index]
                                      .stepNum}'),
                            child: ThemeLogicDesignScreen()
                        ),
                        lastProblem: false,
                        index: stageNum,
                      );
                    }
                    else {
                      return ThemeQuizPracticeCard(
                        progressNum: '$stageNum-${index+1}',
                        levelTime: _timeConverter(index),
                        projectNum: 'STEP ${index + 1}',
                        titleText:
                        "${_projectList[index].title}",
                        contentText: _projectList[index].description,
                        practicePage: ChangeNotifierProvider<ThemeCodingProvider>.value(
                            value: ThemeCodingProvider()
                              ..loadSelectedLogicList(
                                  _projectList[index],
                                  _projectList[index].logicList,
                                  '${_projectList[index]
                                      .stageNum}-${_projectList[index]
                                      .stepNum}'),
                            child: ThemeLogicDesignScreen()
                        ),
                        lastProblem: true,
                        index: stageNum,
                      );
                    }
                  },
                );
              }
            }
        )
    );
  }

  String _timeConverter(int index) {
    int record =
        UserProvider.getUser().projectRecords['$stageNum-${index + 1}'] ?? 0;
    var f = NumberFormat("00");

    return '${f.format(record ~/ 60)} : ${f.format(record % 60)}';
  }
}
