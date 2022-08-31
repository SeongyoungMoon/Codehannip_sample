import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/routes.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/store_kit_wrappers.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';


class SubscribePay extends StatefulWidget{
  @override
  SubscribePayState createState() => SubscribePayState();
}

class SubscribePayState extends State<SubscribePay>{

  bool select1; //월간
  bool select2; //연간
  final InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;
  bool isPurchased = false;

  @override
  void initState() {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    provider.verifyPurchase();
    select1 = false;
    select2 = false;
    super.initState();
  }

  void _buyProduct(ProductDetails prod) async{
    var purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Widget _SubscribePay(){
    var provider = Provider.of<ProviderModel>(context, listen: false);

    return ListView(
        children:[
          Text(
            "오픈 기념 세일!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
            ),

          SizedBox(height: 12.0),

          Text(
            "지금 결제하고 해지 전까지\n할인된 가격으로 결제하세요",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall
          ),

          SizedBox(height: 24.0),

          Text(
              "무료 체험 이후에 시작할 멤버십을 고르세요",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium
          ),

          //월간 이용
          Container(
            padding: EdgeInsets.all(16.0),
            child: Card(
              shape: !select1 ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ) : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3
                ),
              ),
              elevation: 3,
              child: InkWell(
                splashColor: Colors.grey.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                  setState((){
                    select1 = true;
                    //select2 = false;
                  });
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //color: Colors.pink,
                              padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: Text(
                                "베이직, 1개월",
                                //style: Theme.of(context).textTheme.headline4
                                style: Theme.of(context).textTheme.displayLarge
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(height: 20.0),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  padding: EdgeInsets.fromLTRB(12, 1, 12, 2),
                                  child: Text(
                                    '67% 할인',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),

                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height : 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              //color: Colors.amber,
                              padding: EdgeInsets.fromLTRB(0, 7.0, 5.0, 3.0),
                              child: Text(
                                "15,000",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.secondary,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Theme.of(context).colorScheme.secondary,
                                  decorationThickness: 10,
                                ),
                              ),
                            ),
                            Text(
                              provider.products[0].price,
                              textAlign: TextAlign.end,
                              style:Theme.of(context).textTheme.displayLarge,
                            ),
                            // Container(
                            //   padding: EdgeInsets.fromLTRB(0, 7.0, 5.0, 3.0),
                            //   child: Text('/월',
                            //     style: TextStyle(
                            //       fontSize: 17,
                            //       color: Color(0xFF747474),
                            //       decorationColor: Color(0xFF747474),
                            //       decorationThickness: 2.5,
                            //     ),),
                            // ),
                          ],
                        )
                      ]
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 36.0),

          //연간 이용권
          // Container(
          //   padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
          //   child: Card(
          //     shape: !select2 ? RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15.0),
          //     ) : RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15.0),
          //       side: BorderSide(
          //           color: Theme.of(context).colorScheme.primary,
          //           width: 8
          //       ),
          //     ),
          //     elevation: 4,
          //     child: InkWell(
          //       splashColor: Colors.grey.withAlpha(30),
          //       onTap: () {
          //         print('Card tapped.');
          //         setState((){
          //           select2 = true;
          //           select1 = false;
          //         });
          //       },
          //       child: Container(
          //         padding: EdgeInsets.fromLTRB(8.0, 5.0, 25.0, 20.0),
          //         child: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 padding: EdgeInsets.fromLTRB(10.0, 10, 0, 0),
          //                 child: Text(
          //                     "연간 이용권",
          //                   style: TextStyle(
          //                     fontSize: 25,
          //                     fontWeight: FontWeight.w700,
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(height : 25.0),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 crossAxisAlignment: CrossAxisAlignment.end,
          //                 children: [
          //                   Container(
          //                     padding: EdgeInsets.fromLTRB(0, 7.0, 5.0, 3.0),
          //                     child: Text(
          //                       "180,000",
          //                       style: TextStyle(
          //                         fontSize: 17,
          //                         color: Color(0xFF747474),
          //                         decoration: TextDecoration.lineThrough,
          //                         decorationColor: Color(0xFF747474),
          //                         decorationThickness: 2.5,
          //                       ),
          //                     ),
          //                   ),
          //                   Text(
          //                     "80,000",
          //                     textAlign: TextAlign.end,
          //                     style: TextStyle(
          //                       fontSize: 28,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                   ),
          //                 ],
          //               )
          //             ]
          //         ),
          //       ),
          //     ),
          //   ),
          // )

          //Button->이 버튼 누르면 결제 되게 하면 됨!
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                  heroTag: null,
                  onPressed: () async {
                    //todo: 결제
                    try {
                      for (var prod in provider.products) {
                        print(provider.products.length);
                        if (provider.hasPurchased(prod.id) != null) {
                          print("product 연결 안됨");
                        } else {
                          /*var transactions = await SKPaymentQueueWrapper().transactions();
                          transactions.forEach((skPaymentTransactionWrapper) {
                            SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
                          });*/
                          _buyProduct(prod);
                          /*setState(() {
                            print("사용자 구매정보 업데이트");
                            print(isPurchased);
                          });*/
                          /*transactions.forEach((skPaymentTransactionWrapper) {
                            SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
                          });*/
                        }
                      };
                    } catch (e) {
                      print("User canceled");
                    }
                  },
                  label: Text("7일 무료 체험 후 결제하기"),
                  extendedTextStyle: Theme.of(context).textTheme.displaySmall
                  //child: Icon(Icons.check),
                ),
              ],
            ),
          ),

          //개인 정보 링크
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => PrivacyWebPage(),
                            fullscreenDialog: true
                        ),
                      );
                    },
                    child: Text(
                      "개인정보보호정책",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    ),
                    TextButton(
                      onPressed:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ServiceWebPage(),
                              fullscreenDialog: true
                          ),
                        );
                      },
                      child: Text(
                        "서비스 이용약관",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                       ),
                    ],
          ),
          ),


            Text(//todo: "자동 결제 3일전 푸시알림으로 알려드립니다.\n"
              "프로그램의 해지 및 환불은 구글 플레이 스토어\n"
                  "혹은 앱스토어에서 언제든 가능합니다",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
    ]
    );
  }


  Widget _SubscribeClear(){
    var height = MediaQuery.of(context).size.height;

    return ListView(
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
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 23,
            ),
          ),
          Text(
            "파이썬의 모든 스테이지를 해금하세요",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              //fontSize: 18,
            ),
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.home, ModalRoute.withName(Routes.home));
                  },
                  label: Text("홈화면으로 돌아가기"),
                  //child: Icon(Icons.check),
                ),
              ],
            ),
          ),

          Text("자동 결제 3일전 푸시알림으로 알려드립니다.\n"
              "프로그램의 해지 및 환불은 구글 플레이 스토어\n"
              "혹은 앱스토어에서 언제든 가능합니다",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context){
    var provider = Provider.of<ProviderModel>(context);
    isPurchased = provider.isPurchased;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title:  Text(
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
                child:  isPurchased ? _SubscribeClear() : _SubscribePay(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyWebPage extends StatefulWidget {
  PrivacyWebPage({Key key}) : super(key: key);

  @override
  _PrivacyWebPageState createState() => _PrivacyWebPageState();
}

class _PrivacyWebPageState extends State<PrivacyWebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://blog.naver.com/greediteam/222184204099',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}

class ServiceWebPage extends StatefulWidget {
  ServiceWebPage({Key key}) : super(key: key);

  @override
  _ServiceWebPageState createState() => _ServiceWebPageState();
}

class _ServiceWebPageState extends State<ServiceWebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://blog.naver.com/greediteam/222525122976', // apple: https://blog.naver.com/greediteam/222525122976 google: https://blog.naver.com/greediteam/222629788970
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}