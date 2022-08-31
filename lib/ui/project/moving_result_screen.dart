import 'package:code_hannip/providers/project_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovingResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<MovingResultScreen> {

  String result = "";
  bool correct = false;
  List<GlobalKey<FormState>> formKeys = [];
  List<TextEditingController> controllers = [];

  var inputList = [];
  var answerList;
  var resultList;

  Map executionStrMap;

  ProjectProvider projectProvider;


  @override
  void initState() {
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    //print(projectProvider.projectModel.resultList);
    answerList = projectProvider.projectModel.answerList.entries
        .map((e) => e.value.join(' '))
        .toList();
    resultList = projectProvider.projectModel.resultList.entries
        .map((e) => e.value.join(' ')) //todo: answerList -> resultList
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
    final projectProvider =
    Provider.of<ProjectProvider>(context, listen: false);

    var projectNum = projectProvider.projectModel.stageNum % 10 + 1;
    print(projectNum);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          //leading: Container(),//todo: containter로 가려놨던데 아이콘 넣을까..
          title: Text(
            'Project '+projectNum.toString()+' '+projectProvider.projectModel.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Color(0xffE74C3C),),
              iconSize: 20.0,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 40.0, vertical: 32.0),
                  child: Text(
                    projectProvider.projectModel.problem,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                Text(
                  "실행하기",
                  style:  Theme.of(context).textTheme.overline,
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      answerListColumn(answerList),
                      // answerListColumn(executionSList),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFC4C4C4)),
                    color: Color(0xFFC4C4C4).withOpacity(0.24),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "입력하기",
                  style: Theme.of(context).textTheme.overline,
                ),
                step2(3),
            /*
                Row(
                  children: [
                    Text(
                      "결과보기",
                      style: Theme.of(context).textTheme.overline,
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(height: 8.0),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: checkAnswer ? 8.0 : 28.0),
                    child: checkAnswer ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //result
                        result,
                      ],
                    ) :
                    Center(
                      child: Text(
                        '눌러서 결과보기',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary),
                      ),
                    )//todo: 여기 왜 바로 안떠...?...
                    ,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFC4C4C4)),
                      color: Color(0xFFC4C4C4).withOpacity(0.24),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      checkAnswer = true;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                */

              ],
            ),
          ),
        ),
      ),
    );
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

  Row step3() {
    return Row(
      children: <Widget>[
        //SizedBox(width: ScreenUtil().setHeight(20)),
        Expanded(
          child: Container(
            width: ScreenUtil().setWidth(330),
            height: ScreenUtil().setHeight(80),
            //padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), 0, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFC4C4C4)),
              color: Color(0xFFC4C4C4).withOpacity(0.24),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              correct ? result : ' ',
              style: TextStyle(
                  color: Color(0xFF3B3B3B),
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Container step2(int inputNum) {
    List<Widget> _line = [];
    List<String> _value = ['num1', 'num2', 'operator'];
    List<String> _inputType = ['num', 'num', 'op'];
    List<String> vals = [];

    if (formKeys.isEmpty && controllers.isEmpty) {
      if(inputNum != 0){
        for (var i = 0; i < inputNum; i++) {
          formKeys.add(GlobalKey<FormState>());
          controllers.add(TextEditingController());
        }
      }
    }

    for (var i = 0; i < inputNum; i++) {
      _line.add(
        SafeArea(
          child: Form(
            key: formKeys[i],
            child: Row(
              children: <Widget>[
                SizedBox(width: ScreenUtil().setWidth(20)),
                Container(
                    height: ScreenUtil().setHeight(30),
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setWidth(5.0),
                        ScreenUtil().setWidth(5.0),
                        ScreenUtil().setWidth(1.0)),
                    child: Text(
                      '${_value[i]} =',
                      style: TextStyle(
                          color: Color(0xFF3B3B3B),
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w800),
                    )),
                Spacer(),
                Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(200),
                  //todo: 변수길이조절 확인
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey[300],// set border color
                        width: 1.5),   // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(8.0)), // set rounded corner radius
                  ),
                  child: TextFormField(
                    validator: (value) {
                      vals.insert(i, value);
                      if (value.isEmpty) {
                        return '값을 입력하세요';
                      }
                      else if (_inputType[i] == 'num') {
                        if (!isNum(value)) {
                          return '숫자를 입력하세요';
                        }
                      }
                      return null;
                    },
                    controller: controllers[i],
                    textAlign: TextAlign.left,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                        color: Color(0xFF9C9C9C),
                        fontSize: ScreenUtil().setSp(17),
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    autocorrect: false,
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(20)),
              ],
            ),
          ),
        ),
      );
      _line.add(SizedBox(
        height: ScreenUtil().setHeight(10),
      ));
    }

    _line.add(
      Row(
        children: <Widget>[
          Container(
            /*padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(21.0),
                ScreenUtil().setWidth(5.0),
                ScreenUtil().setWidth(5.0),
                ScreenUtil().setWidth(1.0)),*/
            child: Text(
              "결과보기",
              style: Theme.of(context).textTheme.overline,
            ),
          ),
        ],
      ),
    );


    _line.add(
      SizedBox(height: 20,)
    );

    _line.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          step3(),
        ],
      ),
    );


    //_lineAll.add(Column(children: _line,));

    _line.add(Align(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(80.0),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(8.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  backgroundColor: Color(0xffE74C3C),
                  heroTag: null,
                  onPressed: () {
                    setState(() {

                      /*
                      Future.delayed(Duration(microseconds: 500), () {
                        //call back after 500  microseconds
                        for (var i = 0; i < inputNum; i++) {
                          controllers[i].clear();
                        }
                      });
                       */

                      var _correctNum = 0;
                      num cal = 0;

                      for (var i = 0; i < inputNum; i++) {
                        if (formKeys[i].currentState.validate()) {
                          _correctNum++;
                        }
                      }

                      if (_correctNum == inputNum) {

                        if(vals[2] == '+') {
                          cal = num.parse(vals[0]) + num.parse(vals[1]);
                          result = cal.toString();
                        }
                        else if(vals[2] == '-') {
                          cal = num.parse(vals[0]) - num.parse(vals[1]);
                          result = cal.toString();
                        }
                        else if(vals[2] == '*') {
                          cal = num.parse(vals[0]) * num.parse(vals[1]);
                          result = cal.toString();
                        }
                        else if(vals[2] == '/') {
                          cal = num.parse(vals[0]) / num.parse(vals[1]);
                          result = cal.toString();
                        }
                        else {
                          result = "정확한 연산기호를 입력해주세요.";
                        }
                      }
                      correct = true;
                    });
                  },
                  label: Text("결과를 확인 해 봅시다!"),
                  //child: Icon(Icons.check),
                ),
              ],
            ),
          ),
        ],
      ),
    ));

    return Container(child: Column(children: _line));
  }

  bool isNum(String value) {
    return double.tryParse(value) != null;
  }

  bool isString(String value) {
    if (value is String) {
      return true;
    } else {
      return false;
    }
  }

}
