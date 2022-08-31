import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../routes.dart';

class CardTutorialScreen extends StatefulWidget {
  @override
  _CardTutorialScreenState createState() => _CardTutorialScreenState();
}

class _CardTutorialScreenState extends State<CardTutorialScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  var _currentPage = 0;

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CardTutorialScreen()),
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
          "터치 코딩 튜토리얼",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          _currentPage != 4
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
                titleWidget: Column(
                  children: [
                    //SizedBox(height: phoneSize.height * 0.07),
                    Text(
                      "POINT 1",
                      style: Theme.of(context).textTheme.titleSmall.copyWith(color: Theme.of(context).colorScheme.primary)
                    )
                  ]
                ),
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "코드에 대한 설명과\n예제를 통해 개념을 익혀봅시다.",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/touch_tutorial_1.png",
                    //height: phoneSize.height * 0.43,
                  ),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: Column(
                  children: [
                    //SizedBox(height: phoneSize.height * 0.07),
                    Text(
                        "POINT 2",
                        style: Theme.of(context).textTheme.titleSmall.copyWith(color: Theme.of(context).colorScheme.primary)
                    )
                  ],
                ),
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '실전 문제의 로직이란\n문제 해결 순서를 나열한 것입니다',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: phoneSize.height * 0.03),
                    Text(
                      '컴퓨터는 한번에 한가지 행동만 할 수 있어요!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/touch_tutorial_2.png",
                    //height: phoneSize.height * 0.43,
                  ),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: Column(
                  children: [
                    //SizedBox(height: phoneSize.height * 0.07),
                    Text(
                        "POINT 3",
                        style: Theme.of(context).textTheme.titleSmall.copyWith(color: Theme.of(context).colorScheme.primary)
                    )
                  ],
                ),
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '메인 코딩 문제를 확인하고\n 이를 위한 로직 순서를 맞춰봅시다',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: phoneSize.height * 0.03),
                    Text(
                      '로직 카드가 선택될 때까지 꾹 눌러주세요 ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/touch_tutorial_3.png",
                    //height: phoneSize.height * 0.43,
                  ),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: Column(
                  children: [
                    //SizedBox(height: phoneSize.height * 0.07),
                    Text(
                        "POINT 4",
                        style: Theme.of(context).textTheme.titleSmall.copyWith(color: Theme.of(context).colorScheme.primary)
                    )
                  ],
                ),
                body: "로직에 맞게 코딩 카드를\n배치하여 코드를 완성합시다",
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/touch_tutorial_4.png",
                    //height: phoneSize.height * 0.43,
                  ),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                  titleWidget: Column(
                    children: [
                      //SizedBox(height: phoneSize.height * 0.07),
                      Text(
                          "POINT 5",
                          style: Theme.of(context).textTheme.titleSmall.copyWith(color: Theme.of(context).colorScheme.primary)
                      )
                    ],
                  ),
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '완성된 코드를 실행시켜\n입력값에 따른 출력값을 확인합니다',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: phoneSize.height * 0.02),
                    Text(
                      '참고로 ‘>>>’ 는 코딩에서 입력값과\n출력값을 보여주겠다는 신호입니다',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                image: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/touch_tutorial_5.png", //임의로 height, width 값 조절해놓은 이미지
                  ),
                ),
                decoration: pageDecoration,
              ),
              // PageViewModel(
              //   title: "",
              //   bodyWidget: Center(
              //       child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("이제 코딩 공부하러 가볼까요?",
              //         style: Theme.of(context).textTheme.headlineSmall,
              //         textAlign: TextAlign.center,),
              //     ],
              //   )),
              //   image: Placeholder(),
              // ),
            ],
            onDone: () => _onIntroEnd(context),
            showNextButton: false,
            isProgressTap: true,
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
                _currentPage = value;
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
          //         color: _currentPage != 0
          //             ? Theme.of(context).iconTheme.color
          //             : Colors.transparent,
          //       ),
          //       Icon(Icons.arrow_forward_ios,
          //           color: _currentPage != 5
          //               ? Theme.of(context).iconTheme.color
          //               : Colors.transparent),
          //     ],
          //   ),
          // ),
          _currentPage == 4
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
    await _userRepository.updateTutoList(0);
    await Navigator.of(context).pushReplacementNamed(Routes.quizMain);
  }
}
