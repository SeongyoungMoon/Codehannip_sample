import 'package:code_hannip/models/column_model.dart';
import 'package:code_hannip/models/concept_model.dart';
import 'package:code_hannip/services/data_repository/colum_repository.dart';
import 'package:code_hannip/ui/quiz_concept/tab_screen.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flutter/material.dart';
import 'package:code_hannip/ui/quiz_example/quiz_example_screen.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/providers/user_provider.dart';

class QuizConceptScreen extends StatefulWidget {
  final ConceptModel concept;
  //final Widget examplePage;

  QuizConceptScreen(
      this.concept,
      //this.examplePage
  );
  @override
  _QuizConceptScreenState createState() => _QuizConceptScreenState();
}

class _QuizConceptScreenState extends State<QuizConceptScreen>
    with SingleTickerProviderStateMixin {
  String conceptNum;
  int conceptProgress;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final _columnRepository = ColumnRepository();
    return StreamBuilder<List<ColumnModel>>(
        stream: _columnRepository.columnStream(widget.concept.documentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var column = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 0.0,
              //   title:  Text(
              //     "STEP ${widget.concept.step} ${widget.concept.title} 개념",
              //     style: Theme.of(context).textTheme.headline6,
              // ),
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body:
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        TabScreen(column: column[0]),
                        SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(24, 0, 24, 140),
                            scrollDirection: Axis.horizontal,
                            child:
                            Image.asset("assets/images/${widget.concept.stage}-${widget.concept.step}.png",
                                fit: BoxFit.cover)
                        ),
                      ],
                    ),
                  ),

              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: ExtendedFAB(
                title: "개념 확인 완료",
                icon: Icons.check,
                function: () {
                  conceptNum = "${widget.concept.stage}-${widget.concept.step}";
                  conceptProgress = UserProvider.getUser().conceptProgress[conceptNum];
                  if(conceptProgress == null){
                    UserRepository().updateConceptProgress(conceptNum, 1);
                  }
                  Navigator.pop(context); //todo: 회색줄뜨는데 동작은 됨.. 글고 여기 pop 말고 뭐해야하지
                  //_navigateAndupdate(context, widget.examplePage);
                  },
              ),
            );
          } else {
            return Container(
              width: 0,
              height: 0,
            );
          }
        });
  }

  _navigateAndupdate(BuildContext context, Widget page) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page)
    ).then((value) => setState(() {}));

  }
}


