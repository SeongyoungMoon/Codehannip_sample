import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/providers/theme_coding_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/project/camera_logic_check.dart';
import 'package:code_hannip/ui/themecoding/theme_logic_check_scree.dart';
import 'package:code_hannip/widgets/answer_dialog.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'theme_logic_check_screen.dart';

class ThemeLogicDesignScreen extends StatefulWidget {
  @override
  _ThemeLogicDesignScreenState createState() => _ThemeLogicDesignScreenState();
}

class _ThemeLogicDesignScreenState extends State<ThemeLogicDesignScreen> {
  ScrollController _scrollController;
  ThemeCodingProvider projectProvider;

  @override
  void initState() {
    projectProvider = Provider.of<ThemeCodingProvider>(context, listen: false);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery
        .of(context)
        .size;
    projectProvider = Provider.of<ThemeCodingProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
          transform:  Matrix4.translationValues(10.0, 0.0, 0.0),
          child:Text(
          projectProvider.projectModel.title,
          style: Theme
              .of(context)
              .textTheme
              .displayMedium,
        ),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: phoneSize.height * 0.01,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(3),
                height:22,
                width: 77,
                child: Text(
                  '메인 문제',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Center(
              child: Container(
                width: phoneSize.width * 0.9,
                child: Text(
                  projectProvider.projectModel.problem,
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: phoneSize.height * 0.05,
            ),
            Expanded(
              child: Consumer<ThemeCodingProvider>(
                  builder: (_, projectProvider, __) =>
                  projectProvider
                      .selectedLogicList.isEmpty
                      ? Container()
                      : NotificationListener<ScrollNotification>(
                    // ignore: missing_return
                    onNotification: (scrollNotification) {
                      if (_scrollController.offset >=
                          _scrollController.position.maxScrollExtent - phoneSize.height * 0.12) {
                        Future.delayed(Duration(milliseconds: 200), () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent - phoneSize.height * 0.13,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListView(
                            children: List<Widget>.generate(
                                projectProvider.selectedLogicList.length,
                                    (index){
                                  var realIndex = index +1;
                                  return Container(
                                    height: 64,
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      '$realIndex.',
                                      style: Theme.of(context).textTheme.displayLarge
                                          .copyWith(color: Theme.of(context).colorScheme.primary),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: ReorderableListView(
                            scrollController: _scrollController,
                            children: List<Widget>.generate(
                                projectProvider.selectedLogicList.length,
                                    (index) {
                                  return Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    key: ValueKey(
                                        projectProvider.selectedLogicList[index]),
                                    // elevation: 1,
                                    child: ReorderableDragStartListener(
                                      index: index,
                                      child: ListTile(
                                        tileColor: Theme.of(context).colorScheme.primaryContainer,
                                        title: Text(
                                            projectProvider.selectedLogicList[index],
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                        trailing: Icon(
                                          Icons.swap_vert,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            onReorder: (oldIndex, newIndex) {
                              projectProvider.updateSelectedLogicList(
                                  oldIndex, newIndex);
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
              child: ExtendedFAB(
                  icon: Icons.check,
                  title: '정답 확인하기',
                  function: () =>
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Function eq = const ListEquality().equals;
                            return AnswerDialog(
                              isCorrect: eq(projectProvider.selectedLogicList,
                                  projectProvider.projectModel.logicList),
                              function: () =>
                              UserProvider.isTouchCoding()
                                  ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChangeNotifierProvider.value(
                                              value: projectProvider,
                                              child: ThemeLogicCheckScreen())))
                                  : Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChangeNotifierProvider.value(
                                              value: projectProvider,
                                              child: ThemeLogicCheckScreen()//CameraLogicCheck()
                                          ))),
                            );
                          })),
            )
          ],
        ),
      ),
    );
  }
}
