import 'package:code_hannip/ui/home/home.dart';
import 'package:code_hannip/ui/subscribe/subcribe_pay_page.dart';
import 'package:flutter/material.dart';

class SubscribeClear extends StatefulWidget{
  @override
  SubscribeClearState createState() => SubscribeClearState();
}

class SubscribeClearState extends State<SubscribeClear>{
  @override
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "코드한입 멤버쉽 가입",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                    children:[
                      SizedBox(height: height*0.05),
                      Image.asset(
                        'assets/images/checkbox_marked.png',
                        fit: BoxFit.contain,
                        height: height * 0.2,
                      ),
                      Text(
                        "결제가 완료되었습니다!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: height*0.018),
                      Text(
                        "파이썬의 모든 스테이지를 해금하세요",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      SizedBox(height: height*0.3),

                      //Button
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              heroTag: null,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => HomeScreen(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.arrow_forward),
                              label: Text("홈화면으로 돌아가기", style: Theme.of(context).textTheme.displaySmall),
                              //child: Icon(Icons.check),
                            ),
                          ],
                        ),
                      ),

                      Text("자동 결제 3일전 푸시알림으로 알려드립니다.\n"
                          "프로그램의 해지 및 환불은 구글 플레이 스토어\n"
                          "혹은 앱스토어에서 언제든 가능합니다",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}