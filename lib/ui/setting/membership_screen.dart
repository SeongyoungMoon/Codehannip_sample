import 'dart:io';

import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/subscribe/subcribe_pay_page.dart';
import 'package:code_hannip/ui/subscribe/subscribe_main.dart';
import 'package:code_hannip/widgets/apple_subscribe_dialog.dart';
import 'package:code_hannip/widgets/subscribe_dialog.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MembershipScreen extends StatefulWidget {
  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;
  bool sub = false; //todo: 결제를 했는지 확인해주는 임의 변수
  bool isGuest = false;
  bool _showAppleSignIn;

  @override
  void initState() {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    if(UserProvider.getUser().phoneNum == '0100000000') isGuest = true;
    provider.verifyPurchase();
    sub = provider.isPurchased;
    if (Platform.isIOS) {
      setState(() {
        _showAppleSignIn = true;
      });
    } else {
      _showAppleSignIn = false;
    }
    //print(123321);
    //print(provider.products[0].rawPrice);
    //print(provider.products[0].description);
    super.initState();
  }


  //todo: 결제 후에 연결제 or 월결제 중 하나만 나오게 바꿔야 함!
  Widget subscribe(context, var provider){
    var height = MediaQuery.of(context).size.height;
    if(provider.isWadiz){
      return ListView(
        children: [
          SizedBox(height: 5.0),
          //월 결제 멤버십 카드
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 20.0, 5.0, 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "와디즈 서포터 멤버쉽",
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayLarge
                  ),
                  SizedBox(height: 25.0),
                  Text(
                      "구독 기간: ${DateFormat('yyyy-MM-dd').format(provider.wadizStart)} ~ ${DateFormat('yyyy-MM-dd').format(provider.wadizEnd)}", //todo: 구독 기간
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium
                  ),
                  SizedBox(height: 5.0),
                  Text(
                      "와디즈 6개월 리워드를 사용하고 있습니다. 와디즈에 사용 후기를 남겨주세요 :)", //todo: 다음 결제일
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall)
                ]
            ),
          ),

          SizedBox(height: height * 0.4),

          Column(
            children: [
              Text(
                "해지 혹은 환불은 구글 플레이 스토어 혹은\n앱스토어에서 진행해 주시길 바랍니다",
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      );
    } else {
      return ListView(
        children: [
          //연 결제 멤버십 카드
          /* Container(
          padding: EdgeInsets.fromLTRB(8.0, 20.0, 5.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "연 결제 멤버십",
                  style: Theme.of(context).textTheme.headline4
              ),
              SizedBox(height : 25.0),
              Text(
                  "구독 기간: 여기에 구독 기간 받아오는 변수 넣으면 된당!", //todo: 구독 기간
                  style: Theme.of(context).textTheme.bodyText1
              ),
              SizedBox(height : 5.0),
              Text(
                  "다음 결제일: 여기에 한 달 후 결제 일 변수 넣으면 된당!", //todo: 결제일
                  style: Theme.of(context).textTheme.bodyText1)
            ]
          ),
        ),*/

          SizedBox(height: 5.0),
          //월 결제 멤버십 카드
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 20.0, 5.0, 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "결제 멤버십",
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayLarge
                  ),
                  SizedBox(height: 25.0),
                  Text(
                      "구독 기간: 1 개월", //todo: 구독 기간
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium
                  ),
                  SizedBox(height: 5.0),
                  Text(
                      provider.products[0].description, //todo: 다음 결제일
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall)
                ]
            ),
          ),

          SizedBox(height: height * 0.4),

          Column(
            children: [
              Text(
                "해지 혹은 환불은 구글 플레이 스토어 혹은\n앱스토어에서 진행해 주시길 바랍니다",
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      );
    }

  }

  Widget notsubscribe(){
    return ListView(
      children: [
        SizedBox(height: 80.0),
        Text(
          "아직 가입된 멤버쉽이 없습니다\n가입하러 가시겠어요?",
          textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .headlineSmall
        ),
        SizedBox(height : 250.0),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation:0.0,
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
                label: Text(
                    "멤버십 가입하러 가기",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                icon: Icon(Icons.arrow_forward,)
                //child: Icon(Icons.check),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
        transform:  Matrix4.translationValues(10.0, 0.0, 0.0),
        child: Text(
          "멤버쉽 확인",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: isGuest? SubDialog()
                    : sub == false? notsubscribe() : subscribe(context, provider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}