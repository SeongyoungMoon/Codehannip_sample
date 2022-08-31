import 'package:code_hannip/widgets/custom_expansion_tile.dart' as custom;
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<Faq> _faqList = <Faq>[];

  @override
  void initState() {
    _faqList.add(Faq(
        title: "코딩 카드를 어떻게 사용해야 될지 모르겠어요",
        contents: "현재 저희는 혼자하기 튜토리얼을 통해 카드를 어떻게 사용하는지 알려 드리고 있습니다!\n"
            "하지만 튜토리얼을 다시 볼 수 없는 분들을 위해 간단하게 설명드리자면! "
            "코딩 카드를 한 번 누르거나 옆으로 살짝 밀면 카드가 뒤집혀 카드의 의미를 알 수 있습니다. "
            "그리고 카드를 드래그 해 원하는 위치에 놓을 수 있습니다! 🙂",
        isExpanded: false));
    _faqList.add(Faq(
        title: "가끔 어플리케이션이 제대로 작동하지 않아요ㅜㅜ",
        contents: "죄송합니다! 이상하거나 부족한 부분이 있다면 저희의 이메일로 "
            "문의를 주시면 바로 피드백하도록 하겠습니다! 추후에 추가 될 신고하기 "
            "칸을 통해 더 편하게 소통 할 수 있도록 하겠습니다 🙂",
        isExpanded: false));
    _faqList.add(Faq(
        title: "코딩 개념 중에서 이해 안 되는게 있어요",
        contents: "모르는 것이 있다면 언제든지 코드한입 이메일로 보내주시면 추가 "
            "설명 답장드리겠습니다. 추후에 질문칸을 만들어 소통이 쉽게 도와드리겠습니다 🙂",
        isExpanded: false));
    _faqList.add(Faq(
        title: "실전문제에서 카드 놓을 곳을 못 찾겠어요!",
        contents: "코딩 카드는 남아 있는데, 카드를 놓을 공간이 더 이상 없는 경우엔 "
            "코딩 라인을 왼쪽으로 밀어보세요! "
            "코딩 빈칸이 숨어 있을 수 있으니, 밀어보신 후 즐거운 코딩을 즐겨주세요 🙂",
        isExpanded: false));
    _faqList.add(Faq(
        title: "문제에 이상한 부분이 있는거 같아요!",
        contents: "앗! 어떠한 부분이 이상하고, 오류가 있는지 저희의 이메일로 알려주시면 바로 "
            "고치도록 하겠습니다 😉 여러분들의 소중한 의견으로 더욱 발전하는 "
            "모습 보여드리겠습니다 +ㅇvㅇ+",
        isExpanded: false));
    _faqList.add(Faq(
        title: "랭킹이 반영 안되는데 왜 이러는건가요??",
        contents: "랭킹의 경우 회원가입, 구글 로그인, 페이스북 로그인, 애플 로그인을 하셨을 경우에만 "
            "실전문제를 풀었을 때 랭킹에 등록이 된답니다 🙂 "
            "혹시 게스트 로그인으로 어플리케이션을 즐기고 계신다면 다른 로그인 방식으로 "
            "즐겨보시는건 어떨까요?",
        isExpanded: false));
    _faqList.add(Faq(
        title: "로그아웃 한 후에 다시 로그인 했는데, 데이터가 다 사라졌어요ㅠㅠ",
        contents: "혹시 게스트 로그인 하기를 하셨나요? 만약 게스트로 로그인 하셨다면 로그아웃 됐을 시 "
            "플레이한 데이터가 사라집니다 ㅠㅅㅠ 이메일 로그인, 구글 로그인, 페이스북 로그인, "
            "애플 로그인을 이용하셔서 더 많은 컨텐츠를 즐겨주세요 🙂",
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
          "자주하는 질문",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: ListView.builder(
            itemCount: _faqList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    child: custom.ExpansionTile(
                      onExpansionChanged: (bool check) {
                        setState(() {
                          _faqList[index].isExpanded = check;
                        });
                      },
                      title: Text(_faqList[index].title,
                          style: Theme.of(context).textTheme.displaySmall.copyWith(
                              color: _faqList[index].isExpanded == true
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onBackground)),
                      iconColor: Colors.transparent,
                      trailing: _faqList[index].isExpanded == false
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
                            _faqList[index].contents,
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
                      color: _faqList[index].isExpanded == true
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

class Faq {
  String title;
  String contents;
  bool isExpanded;

  Faq({this.title, this.contents, this.isExpanded = false});
}
