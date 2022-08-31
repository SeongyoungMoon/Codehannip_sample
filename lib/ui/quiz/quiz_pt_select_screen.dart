import 'package:code_hannip/models/project_model.dart';
import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/data_repository/project_repository.dart';
import 'package:code_hannip/ui/project/logic_design_screen.dart';
import 'package:code_hannip/widgets/quiz_practice_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QuizPtSelectScreen extends StatelessWidget {
  final int stageNum;
  final String stageName;

  const QuizPtSelectScreen({Key key, this.stageNum, this.stageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var projectRepository = ProjectRepository();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0.0,
        title: Transform(
          transform: Matrix4.translationValues(10.0, 0.0, 0.0),
          child: Text(
          "$stageName",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: StreamBuilder<List<ProjectModel>>(
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
                      return QuizPracticeCard(
                        progressNum: '$stageNum-${index+1}',
                      levelTime: _timeConverter(index),
                      projectNum: 'PROBLEM ${index + 1}',
                      titleText:
                      "${_projectList[index].title}",
                      contentText: _projectList[index].description,
                      practicePage: ChangeNotifierProvider<ProjectProvider>.value(
                          value: ProjectProvider()
                            ..loadSelectedLogicList(
                                _projectList[index],
                                _projectList[index].logicList,
                                '${_projectList[index]
                                    .stageNum}-${_projectList[index]
                                    .stepNum}'),
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
