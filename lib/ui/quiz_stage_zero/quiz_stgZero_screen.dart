import 'package:code_hannip/ui/quiz_stage_zero/quiz_stgZero_concept_screen.dart';
import 'package:code_hannip/widgets/quiz_stageZero_card.dart';
import 'package:flutter/material.dart';

class QuizStgZeroScreen extends StatelessWidget {
  final int stageNum;
  final String stageName;

  const QuizStgZeroScreen({Key key, this.stageNum, this.stageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
          transform:  Matrix4.translationValues(10.0, 0.0, 0.0),
          child: Text(
          "$stageName",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: List.generate(
            1,
            (index) => Column(
              children: [
                QuizStageZeroCard(
                  step: "STEP 1",
                  titleText: "프로그래밍 시작하기",
                  contentText: "프로그래밍의 개념을 이해해봅시다.",
                  conceptPage: QuizStgZeroConceptScreen(),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
