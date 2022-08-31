import 'package:auto_size_text/auto_size_text.dart';
import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/ui/project/camera_ocr_screen.dart';
import 'package:code_hannip/widgets/cards_dialog.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraLogicCheck extends StatefulWidget {
  @override
  _CameraLogicCheckState createState() => _CameraLogicCheckState();
}

class _CameraLogicCheckState extends State<CameraLogicCheck> {
  ProjectProvider projectProvider;

  @override
  void initState() {
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          projectProvider.projectModel.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CardsDialog(
                        cards: projectProvider.projectModel.cocaList,
                      );
                    });
              })
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: AutoSizeText(
                        projectProvider.projectModel.problem,
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: phoneSize.height * 0.06,
                  ),
                  Text(
                    '코딩 짜기',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  Text(
                    '로직의 순서에 따라 제시된 카드와 동일한 코딩 카드를 알맞게 배치하여 카메라로 인식해 봅시다',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: phoneSize.height * 0.01,
                  ),
                  Container(
                    height: phoneSize.height * 0.5,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,//projectProvider.projectModel.answerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var split =
                            projectProvider.projectModel.answerList[index];
                        return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: phoneSize.height * 0.01),
                                Text(
                                    '${projectProvider.projectModel.logicList[index].toString()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          height: 1.8,
                                        )),
                                Row(
                                  children: List.generate(split.length, (i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 80,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    width: 2))),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: ExtendedFAB(
                      bottomPadding: 1.0,
                      icon: Icons.camera_alt,
                      title: '   카메라로 인식하기',
                      function: fabFunction,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fabFunction() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ChangeNotifierProvider.value(
          value: projectProvider, child: CameraOcrScreen());
    }));
  }

  Widget logicOrder(List<dynamic> strList, Size phoneSize) {
    return Container(
      width: phoneSize.width * 0.9,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFC4C4C4)),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Color(0xFFEDEDED)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(strList.length, (index) {
              return Text('${index + 1}. ${strList[index].toString()}',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.black,
                        height: 1.8,
                      ));
            })),
      ),
    );
  }
}
