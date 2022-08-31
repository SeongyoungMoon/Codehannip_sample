import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogicResultScreen extends StatefulWidget {
  @override
  _LogicResultScreenState createState() => _LogicResultScreenState();
}

class _LogicResultScreenState extends State<LogicResultScreen> {
  var answerList;

  var i = 0;
  ProjectProvider projectProvider;

  @override
  void initState() {
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    answerList = projectProvider.projectModel.answerList.entries
        .map((e) => e.value.join(' '))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            projectProvider.projectModel.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          leading: Container(),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 32.0),
                        child: Text(
                          projectProvider.projectModel.problem,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      Text(
                        "정답 확인",
                        style: Theme.of(context).textTheme.overline,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "아래 코드와 본인이 만든 코드를 비교해봅시다",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            answerListColumn(answerList),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFC4C4C4)),
                          color: Color(0xFFC4C4C4).withOpacity(0.24),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
                ExtendedFAB(
                  icon: Icons.menu,
                  title: '목록으로 돌아가기',
                  function: fabFunction,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fabFunction() async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Widget answerListColumn(List<dynamic> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          list.length,
          (index) => Text(
                list[index],
                style: Theme.of(context).textTheme.bodyText1,
              )),
    );
  }
}
