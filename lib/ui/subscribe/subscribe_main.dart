import 'dart:io';

import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/subscribe/subcribe_pay_page.dart';
import 'package:code_hannip/widgets/apple_subscribe_dialog.dart';
import 'package:code_hannip/widgets/subscribe_dialog.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

class SubscribeMain extends StatefulWidget{
  @override
  SubscribeMainState createState() => SubscribeMainState();
}

class SubscribeMainState extends State<SubscribeMain>{

  bool isGuest = false;
  bool _showAppleSignIn;


  @override
  void initState() {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    provider.verifyPurchase();
    if(UserProvider.getUser().phoneNum == '0100000000') isGuest = true;
    if (Platform.isIOS) {
      setState(() {
        _showAppleSignIn = true;
      });
    } else {
      _showAppleSignIn = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "코드한입 멤버쉽 가입",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _showAppleSignIn? AppleSubDialog() : ListView(
                  children:[
                    Image.asset(
                      'assets/images/subscribe.png',
                      fit: BoxFit.contain,
                      height: height * 0.4,
                    ),
                    Text(
                        "코드한입 잠금 해제하기!",
                        textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(height: height*0.018),
                    Text(
                      "7일간의 무료 체험을 통해\n모든 스테이지를 잠금 해제하세요",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                        //fontSize: 18,
                    ),

                    SizedBox(height: height*0.1),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "현재 최대 ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                        ),
                        Text(
                            "61% ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                        ),
                        Text(
                            "오픈 세일 중!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                        )
                      ],
                    ),

                    //Button
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            elevation: 0.0,

                            heroTag: null,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => SubscribePay(),
                                    fullscreenDialog: true
                                ),
                              );
                            },
                            icon: Icon(Icons.check),
                            label: Text(
                              "멤버십 결제 확인",
                              style: Theme.of(context).textTheme.displaySmall,),
                            //child: Icon(Icons.check),
                          ),
                        ],
                      ),
                    ),
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