import 'package:code_hannip/models/concept_model.dart';
import 'package:code_hannip/models/example_model.dart';
import 'package:code_hannip/providers/example_provider.dart';
import 'package:code_hannip/services/data_repository/concept_repository.dart';
import 'package:code_hannip/services/data_repository/example_repository.dart';
import 'package:code_hannip/ui/quiz_concept/quiz_concept_screen.dart';
import 'package:code_hannip/ui/quiz_example/quiz_example_screen.dart';
import 'package:code_hannip/widgets/quiz_stage_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraQuizStgSelectScreen extends StatelessWidget {
  final int stageNum;
  final String stageName;

  const CameraQuizStgSelectScreen({Key key, this.stageNum, this.stageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _conceptRepository = ConceptRepository();
    final _exampleRepository = ExampleRepository();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "STAGE $stageNum $stageName",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<List<ConceptModel>>(

            ///각 스테이지들에 대한 데이터들을 데이터베이스에 넣은 후 1을 stageNum으로 수정하면 다이나믹하게 그릴 수 있음
            stream: _conceptRepository.conceptStream(stageNum),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var concept = snapshot.data;
                return ListView(
                  children: List.generate(
                    concept.length,
                    (index) => Column(
                      children: [
                        /// QuizConceptScreen()과 QuizExampleScreen()는 이제 Db와 연결(파라미터 필요)
                        QuizStageCard(
                          conceptNum: stageNum.toString()+"-${index + 1}",
                          step: "STEP ${index + 1}",
                          titleText: "${concept[index].title}",
                          contentText: "${concept[index].description}",
                          conceptPage: QuizConceptScreen(concept[index]),
                          examplePage: StreamBuilder<List<ExampleModel>>(
                              stream: _exampleRepository.exampleStream(
                                  concept[index].stage, concept[index].step),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var example = snapshot.data;
                                  var title = "STEP" "${concept[index].step} "
                                      "${concept[index].title} "
                                      "예제";
                                  return ChangeNotifierProvider<
                                      ExampleProvider>.value(
                                    value: ExampleProvider()
                                      ..loadExampleList(example),
                                    child: QuizExampleScreen(
                                        title, example.length, concept[index]),
                                  );
                                } else {
                                  return Scaffold(
                                    body: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                              }),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 0,
                  height: 0,
                );
              }
            }),
      ),
    );
  }

}
