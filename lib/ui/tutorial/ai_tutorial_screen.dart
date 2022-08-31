import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../routes.dart';

class AiTutorialScreen extends StatefulWidget {
  @override
  _AiTutorialScreenState createState() => _AiTutorialScreenState();
}

class _AiTutorialScreenState extends State<AiTutorialScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  var currentPage = 0;

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AiTutorialScreen()),
    );
  }

  // Widget _buildImage(String assetName, String animation) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 36.0),
  //       child: SizedBox(
  //         width: 240,
  //         height: 240,
  //         child: FlareActor('assets/flare/$assetName.flr',
  //             animation: animation,
  //             alignment: Alignment.center,
  //             fit: BoxFit.contain),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    var bodyStyle = Theme.of(context).textTheme.headlineSmall;

    var pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.titleSmall.copyWith(color: Theme.of(context).colorScheme.primary),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.red.withOpacity(0.0),
      imagePadding: EdgeInsets.zero,
      fullScreen: true,
      imageAlignment: Alignment.topCenter,
      imageFlex: 1,
      bodyFlex: 1,
      titlePadding: EdgeInsets.only(top: 45, bottom: 10),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "테마 코딩 튜토리얼",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          currentPage != 2
              ? FlatButton(
                  child: Icon(Icons.clear),
                  onPressed: () {
                    introKey.currentState?.animateScroll(4);
                  },
                )
              : Container(),
        ],
      ),
      body: Stack(
        children: [
          IntroductionScreen(
            key: introKey,
            pages: [
              PageViewModel(
                title: "POINT 1",
                body: "문제를 풀기 전에 프로젝트의\n전체 목표를 확인해주세요",
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/theme_tutorial_1.png",
                    //height: phoneSize.height * 0.43,
                  ),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "POINT 2",
                body: "각 스텝은 전체 코드 중 일부분을\n다루고 있습니다. 스텝을 따라 코드를\n차례로 완성해봅시다. ",
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/theme_tutorial_2.png",
                    //height: phoneSize.height * 0.43,
                  ),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "POINT 3",
                body: "하단의 실행 버튼을 통해\n전체 코드를 확인하고\n완성된 코드를 실행시켜 봅시다.",
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/theme_tutorial_3.png",
                    //height: phoneSize.height * 0.43,
                  ),
                ),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            showNextButton: false,
            skipFlex: 0,
            nextFlex: 0,
            done: const Text(''),
            dotsDecorator: DotsDecorator(
              size: Size(10.0, 10.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              activeSize: Size(10.0, 10.0),
              activeColor: Theme.of(context).iconTheme.color,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            onChange: (value) {
              setState(() {
                currentPage = value;
              });
            },
          ),
          // Center(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Icon(
          //         Icons.arrow_back_ios,
          //         color: currentPage != 0
          //             ? Theme.of(context).iconTheme.color
          //             : Colors.transparent,
          //       ),
          //       Icon(Icons.arrow_forward_ios,
          //           color: currentPage != 4
          //               ? Theme.of(context).iconTheme.color
          //               : Colors.transparent),
          //     ],
          //   ),
          // ),
          currentPage == 2
              ? ExtendedFAB(
                  function: fabFunction,
                  icon: Icons.arrow_forward,
                  title: '문제 풀러가기',
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Future<void> fabFunction() async {
    var _userRepository = UserRepository();
    await _userRepository.updateTutoList(1);
    await Navigator.of(context).pushReplacementNamed(Routes.themeMain);
  }
}
