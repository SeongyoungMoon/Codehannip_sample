import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_hannip/models/project_model.dart';
import 'package:code_hannip/models/record_model.dart';
import 'package:code_hannip/models/theme_model.dart';

import '../firestore_path.dart';
import '../firestore_service.dart';

class ThemeRepository {
  final _firestoreService = FirestoreService.instance;

  // 스테이지별 실전문제 행성 클릭 시 해당하는 프로젝트 불러오는 함수
  Stream<List<ThemeModel>> loadProjects(int stageNum) =>
      _firestoreService.collectionStream(
          path: 'Theme',
          builder: (data, documentId) => ThemeModel.fromMap(data, documentId),
          queryBuilder: (query) => query.where('stageNum', isEqualTo: stageNum),
          sort: (ThemeModel a, ThemeModel b) => a.stepNum.compareTo(b.stepNum));

  // 데이터베이스에 랭킹 데이터 업데이트하는 함수
  Future<void> updateProjectRecords(
      ProjectModel project, List<RecordModel> rankList) async {
    await _firestoreService.setData(
        path: FirestorePath.aProject(project.pid),
        data: project.copyWith(rankList: rankList).toMap(),
        merge: true);
  }

  // 데이터베이스에 프로젝트 추가하는 함수
  // dummy project 에 모델 데이터 업데이트 후 사용.
  Future<void> addProject() async {
    var str =
    await FirebaseFirestore.instance.collection('Theme').doc().id;
    try {
      await _firestoreService.setData(
          path: FirestorePath.aProject(str),
          data: dummyProject(str, 0),
          merge: true);
    } catch (e) {
      print('addProject() error : $e');
    }
  }

  dummyProject(String str, int index) {
    var projectList = [
      ThemeModel(
        stageNum: 4,
        stepNum: 1,
        pid: str,
        title: '과자 불량품 찾기',
        description: '과자의 정보를 비교하여 불량품인지 확인해봅시다.',
        problem: '과자의 무게와 질소량에 따라 "정상" 혹은 "비정상"을 출력해봅시다.\n'
            '\t- 무게가 100 이상이고, 질소량이 30 미만이면 "Sell!"\n'
            '\t- 이외의 경우는 "Drop!"',
        logicList: [
          '과자의 무게와 질소량을 입력받아 봅시다.',
          'if문을 사용하여 과자의 무게가 100이상 이고, 질소량이 30 미만인지 비교해봅시다.',
          'if문이 맞다면 "Sell!"을 출력해봅시다.',
          'else문을 사용하여 나머지 경우를 비교해봅시다.',
          'else문의 조건을 만족할 경우 "Drop!"을 출력해봅시다.',
        ],
        executionStrMap: {
          '2.gas': '과자의 질소량을 입력해주세요',
          '1.weight': '과자의 무게을 입력해주세요',
        },
        cocaList: {
          'function': [
            'int(input())',
            'int(input())',
            'print',
            'print',
          ],
          'controlStatement': [
            'if',
            'else',
          ],
          'variable': [
            'weight',
            'gas',
            'weight',
            'gas',
          ],
          'operator': [
            '=',
            '=',
            '>=',
            'and',
            '<',
          ],
          'dataString': [
            'Sell!',
            'Drop!',
          ],
          'etc': [
            ':',
            ':',
          ],
        },
      ).toMap()
        ..['rankList'] = {}
        ..['answerList'] = {
          '0': ['weight', '=', 'int(input())'],
          '1': ['gas', '=', 'int(input())'],
          '2': ['if', 'weight >= 100', 'and', 'gas < 30', ':'],
          '3': ['\tprint', '(', '"Sell!"', ')'],
          '4': ['else', ':'],
          '5': ['\tprint', '(', '"Drop!"', ')'],
        }
        ..['resultList'] = {
          '0': ['Sell!'],
          '1': ['Drop!'],
        },
    ];

    return projectList[index];
  }
}
