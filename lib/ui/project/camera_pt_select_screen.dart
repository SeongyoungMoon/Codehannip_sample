import 'package:code_hannip/models/project_model.dart';
import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/data_repository/project_repository.dart';
import 'package:code_hannip/ui/project/logic_design_screen.dart';
import 'package:code_hannip/widgets/quiz_practice_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CameraQuizPtSelectScreen extends StatelessWidget {
  final int stageNum;
  final String stageName;

  const CameraQuizPtSelectScreen({Key key, this.stageNum, this.stageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var projectRepository = ProjectRepository();

    List<String> cameralogiclist = ['계산하기', '계산하기', '계산하기'];

    var projectNum = stageNum % 10 + 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "STAGE $projectNum $stageName",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<List<ProjectModel>>(
            stream: projectRepository.loadProjects(stageNum),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                var _projectList = snapshot.data;
                return ListView.separated(
                  itemCount: 1,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                      return QuizPracticeCard(
                        progressNum: '$stageNum-${index+1}',
                      levelTime: '00:00',//_timeConverter(index),
                      projectNum: 'PROJECT ${index + 1}',
                      titleText:
                      '계산기 만들기',//"${_projectList[index].title}",
                      contentText: '계산기를 만들어봅시다!',//_projectList[index].description,
                      practicePage: ChangeNotifierProvider<ProjectProvider>.value(
                          value: ProjectProvider()
                            ..loadSelectedLogicList(
                                _projectList[index],
                                _projectList[index].logicList,
                                '${_projectList[index]
                                    .stageNum}-${_projectList[index]
                                    .stepNum}'
                            ),
                          child: LogicDesignScreen()
                      ),
                    );
                  },
                );
              }
            }
      )
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
