import 'package:code_hannip/models/record_model.dart';
import 'package:meta/meta.dart';

class ProjectModel {
  final int stageNum;
  final int stepNum;
  final String pid;
  final String title;
  final String description;
  final String problem;
  final bool lastProblem;

  final Map<String, dynamic> executionStrMap;
  final List<dynamic> logicList;
  final Map<String, List<dynamic>> cocaList;
  final Map answerList;
  final Map resultList;
  final List<RecordModel> rankList;

  ProjectModel({
    @required this.stageNum,
    @required this.stepNum,
    @required this.pid,
    @required this.title,
    @required this.description,
    @required this.problem,
    @required this.executionStrMap,
    @required this.logicList,
    @required this.cocaList,
    @required this.answerList,
    @required this.resultList,
    @required this.rankList,
    @required this.lastProblem,
  });

  ProjectModel copyWith({
    int stageNum,
    int stepNum,
    String pid,
    String title,
    String description,
    String problem,
    bool lastProblem,
    Map<String, dynamic> executionStrMap,
    List<dynamic> logicList,
    Map<String, List<dynamic>> cocaList,
    Map answerList,
    Map resultList,
    List<RecordModel> rankList,
  }) {
    return ProjectModel(
        stageNum: stageNum ?? this.stageNum,
        stepNum: stepNum ?? this.stepNum,
        pid: pid ?? this.pid,
        title: title ?? this.title,
        description: description ?? this.description,
        problem: problem ?? this.problem,
        executionStrMap: executionStrMap ?? this.executionStrMap,
        logicList: logicList ?? this.logicList,
        cocaList: cocaList ?? this.cocaList,
        answerList: answerList ?? this.answerList,
        resultList: resultList ?? this.resultList,
        rankList: rankList ?? this.rankList,
        lastProblem: lastProblem ?? this.lastProblem);
  }

  factory ProjectModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    String title = data['title'];
    String description = data['description'];
    String problem = data['problem'];
    List rankList = Map.from(data['rankList'] ?? {})
        .entries
        .map((e) => RecordModel(name: e.key, record: e.value))
        .toList();

    var tempAnswerList = Map.from(data['answerList'] ?? {});
    var tempResultList = Map.from(data['resultList'] ?? {});
    var indexes = List.generate(tempAnswerList.length, (index) => index);
    var answerList =
        Map.fromIterables(indexes, indexes.map((i) => tempAnswerList['$i']));
    var resultList =
    Map.fromIterables(indexes, indexes.map((i) => tempResultList['$i']));

    return ProjectModel(
      stageNum: data['stageNum'],
      stepNum: data['stepNum'],
      pid: documentId,
      title: title,
      description: description,
      problem: problem,
      executionStrMap: Map.from(data['executionStrMap'] ?? []),
      logicList: List.from(data['logicList'] ?? []),
      cocaList: Map.from(data['cocaList'] ?? {}),
      answerList: answerList ?? {},
      resultList: resultList ?? {},
      rankList: rankList ?? [],
      lastProblem: data['lastProblem'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stageNum': stageNum,
      'stepNum': stepNum,
      'pid': pid,
      'title': title,
      'description': description,
      'problem': problem,
      'executionStrMap': executionStrMap,
      'logicList': logicList,
      'cocaList': cocaList,
      'lastProblem' : lastProblem,
      'answerList': Map.fromEntries(
              answerList.entries.map((e) => MapEntry('${e.key}', e.value))) ??
          {},
      'resultList': Map.fromEntries(
          resultList.entries.map((e) => MapEntry('${e.key}', e.value))) ??
          {},
      'rankList': rankList != null && rankList.isNotEmpty
          ? Map.fromEntries(rankList.map((e) => MapEntry(e.name, e.record)))
          : {},
    };
  }
}
