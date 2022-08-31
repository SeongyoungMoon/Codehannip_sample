import 'package:flutter/material.dart';

class StgZeroTabScreen extends StatefulWidget {
  final int index;

  const StgZeroTabScreen({Key key, this.index}) : super(key: key);

  @override
  _StgZeroTabScreenState createState() => _StgZeroTabScreenState();
}

class _StgZeroTabScreenState extends State<StgZeroTabScreen> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 24.0),
            widget.index == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '프로그래밍이란?',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        '프로그래밍은 컴퓨터를 움직이게 할 명령들이 모인 프로그램을 만드는 작업입니다. 코딩이라고도 한답니다.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 40.0),
                      Text(
                        '프로그래밍 언어란?',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        '프로그래밍을 할 때 사용되는 언어입니다. 컴퓨터와 사람이 대화하기 위해 사용되는 언어랍니다.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  )
                // : widget.index == 1
                //     ?
            : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '파이썬이란?',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          '프로그래밍 언어의 한 종류입니다. 프로그래밍 언어 중에서 요즘 가장 핫한 언어!',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          '왜 파이썬을 배울까?',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          '누구나 쉽게 배울 수 있습니다. 다른 언어들에 비해 훨씬 간단하거든요. 빠르게 원하는 것을 만들 수 있습니다.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 40.0),
                      //   Align(
                      //     alignment: Alignment.bottomLeft,
                      //     child: Text(
                      //       "예시",
                      //       style: Theme.of(context).textTheme.overline,
                      //     ),
                      //   ),
                      //   Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 8.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "간단한 파이썬 코드를 맛봅시다\n>>>print(\"Hello World!\")",
                      //           style: Theme.of(context).textTheme.bodyText1,
                      //         ),
                      //         SizedBox(height: phoneSize.height * 0.01),
                      //         Container(
                      //           width: phoneSize.width * 0.9,
                      //           padding: EdgeInsets.all(8.0),
                      //           child: Padding(
                      //             padding:
                      //                 const EdgeInsets.symmetric(vertical: 8.0),
                      //             child: Text(
                      //               "Hello World!",
                      //               style: Theme.of(context).textTheme.bodyText2,
                      //             ),
                      //           ),
                      //           decoration: BoxDecoration(
                      //             border: Border.all(color: Color(0xFFC4C4C4)),
                      //             color: Color(0xFFC4C4C4).withOpacity(0.24),
                      //             borderRadius: BorderRadius.circular(5),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      // ),
                    ],
                  )
                  // : Column (
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       '• >>>',
                  //       style: Theme.of(context).textTheme.overline,
                  //     ),
                  //     Text(
                  //       '  : 파이썬으로 코딩을 할 때 우리는 “>>>” 를 만나게 됩니다. “>>>” 은 입력값과 출력값을 여기서부터 보여주겠다! 라는 것을 알려줍니다.',
                  //       style: Theme.of(context).textTheme.bodyText1,
                  //     ),
                  //     SizedBox(height: 40.0),
                  //   ],
                  // )
          ],
        ),
      ),
    );
  }
}
