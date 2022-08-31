import 'package:code_hannip/widgets/custom_expansion_tile.dart' as custom;
import 'package:flutter/material.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final List<Notice> _nList = <Notice>[];

  @override
  void initState() {
    _nList.add(Notice(
        title: "버전 1.0 개발",
        contents: "안녕하세요 프로그래머 한니비 여러분! 반갑습니다 : )\n"
            "드디어 저희 그리디에서 제작한 코딩 교육 어플리케이션 "
            "\'코드한입\'이 개시했습니다! 따-단\n"
            "우리 모두 서로 소통하며 재밌는 코딩 시간을 가졌으면 좋겠습니다 🙂",
        isExpanded: false));
    super.initState();
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
          "공지사항",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: ListView.builder(
            itemCount: _nList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    child: custom.ExpansionTile(
                      onExpansionChanged: (bool check) {
                        setState(() {
                          _nList[index].isExpanded = check;
                        });
                      },
                      title: Text(_nList[index].title,
                          style: Theme.of(context).textTheme.displaySmall.copyWith(
                              color: _nList[index].isExpanded == true
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onBackground)),
                      iconColor: _nList[index].isExpanded == false
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.background,
                      trailing: _nList[index].isExpanded == false
                                  ? Container(
                                      width: 32,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        shape: CircleBorder(),
                                      ),
                                      child: Icon(Icons.arrow_downward, color: Theme.of(context).colorScheme.background,)
                                    )
                                  : Container(
                                      width: 32,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).colorScheme.background,
                                        shape: CircleBorder(),
                                      ),
                                      child: Icon(Icons.arrow_upward, color: Theme.of(context).colorScheme.primary,)
                                    ),
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            _nList[index].contents,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: _nList[index].isExpanded == true
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primaryContainer,
                      borderRadius:
                          BorderRadius.circular(10.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey[300],
                      //     blurRadius: 1,
                      //     spreadRadius: 1,
                      //     offset: Offset(0, 2),
                      //   ),
                      // ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Notice {
  String title;
  String contents;
  bool isExpanded;

  Notice({this.title, this.contents, this.isExpanded = false});
}
