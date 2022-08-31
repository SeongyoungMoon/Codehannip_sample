import 'package:code_hannip/ui/quiz_stage_zero/stgZero_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/providers/user_provider.dart';

class QuizStgZeroConceptScreen extends StatefulWidget {
  @override
  _QuizStgZeroConceptScreenState createState() =>
      _QuizStgZeroConceptScreenState();
}

class _QuizStgZeroConceptScreenState extends State<QuizStgZeroConceptScreen>
    with SingleTickerProviderStateMixin {
  TabController ctr;
  String conceptNum;
  int conceptProgress;

  List<String> tabTitle = ["프로그래밍", "파이썬"];

  @override
  void initState() {
    super.initState();
    ctr = TabController(vsync: this, length: tabTitle.length);
  }

  @override
  void dispose() {
    ctr.dispose();
    super.dispose();
  }

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
          "프로그래밍 시작하기",
          style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
          bottom: TabBar(
            controller: ctr,
            tabs: List.generate(
                tabTitle.length,
                (index) => Tab(
                      text: tabTitle[index],
                    )),
          ),
        ),

      backgroundColor: Theme.of(context).colorScheme.background,
      body: TabBarView(
          controller: ctr,
          children: List.generate(
              tabTitle.length, (index) => StgZeroTabScreen(index: index))),
      floatingActionButton: ExtendedFAB(
        title: "개념 완료",
        icon: Icons.check,
        function: () {
          conceptNum = "0-0";
          conceptProgress = UserProvider.getUser().conceptProgress[conceptNum];
          if(conceptProgress == null){
            UserRepository().updateConceptProgress(conceptNum, 2);
          }
          Navigator.pop(context); //todo: 회색줄뜨는데 동작은 됨.. 글고 여기 pop 말고 뭐해야하지
        },
      ),
    );
  }
}
