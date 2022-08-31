import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/ui/setting/faq_screen.dart';
import 'package:code_hannip/ui/setting/notice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../providers/auth_provider.dart';
import '../../routes.dart';
import 'membership_screen.dart';


class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "마이페이지",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          FlatButton(
            child: Icon(
              Icons.logout,
              size: 24.0,
            ),
            onPressed: () {
              _confirmSignOut(context);
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 24.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/profile.png", width: 82,),
                        SizedBox(width: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: UserProvider.getUser() == null
                              ? Container()
                              : Text(
                            "${UserProvider.getUser().nickname}님",
                            style: Theme.of(context).textTheme.displayLarge.copyWith(
                                color: Theme.of(context).colorScheme.onBackground),
                          ),
                        ),
                      ],
                    ),
                    ///todo: wadiz유저이면 여기에 wadiz 등록된사람이라고 말해주기
                    Align(
                      alignment: Alignment.center,
                      child: provider.isWadiz ?
                      Column(
                        children: [
                          SizedBox(height: 25.0),
                          Text(
                              "와디즈 서포터 멤버십",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2
                          ),
                          SizedBox(height: 5.0),
                          Text(
                              "구독 기간: ${DateFormat('yyyy-MM-dd').format(provider.wadizStart)} ~ ${DateFormat('yyyy-MM-dd').format(provider.wadizEnd)}", //todo: 구독 기간
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ) : Container()
                    ),
                    SizedBox(height: 8.0),
                    SizedBox(height: 40.0),
                    /*_menu(context, "멤버쉽 확인", MembershipScreen()),
                    SizedBox(height: 16.0),*/
                    _menu(context, "공지사항", NoticeScreen()),
                    SizedBox(height: 16.0),
                    _menu(context, "자주하는 질문", FaqScreen()),
                    SizedBox(height: 12.0),
                    //Expanded(child: Container(height: 15)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                .copyWith(color: Theme.of(context).colorScheme.primary),
                            textAlign: TextAlign.start,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                .copyWith(color: Theme.of(context).colorScheme.primary),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.0),
                    Text(
                      "THANKS TO 조성배 교수님",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          .copyWith(color: Theme.of(context).colorScheme.onBackground),
                    ),
                    SizedBox(height: 12.0),
                    /*Text(
                      "현재 버전 beta 1\n이 앱에는 S-Core에서 제공한 에스코어 드림이 적용되어 있습니다",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),*/

                    //개인정보보호정책 링크

                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menu(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            Container(
               width: 32,
               height: 32,
               child: Icon(
                   Icons.arrow_forward,
                   color: Theme.of(context).colorScheme.onPrimary,
               ),
               decoration: ShapeDecoration(
                 color: Theme.of(context).colorScheme.primary,
                 shape: CircleBorder(),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _confirmSignOut(BuildContext context) {
    showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          material: (_, __) => MaterialAlertDialogData(
                  backgroundColor: Theme.of(context).appBarTheme.color),
              title: Text(
                '로그아웃',
              ),
              content: Text('정말로 로그아웃 하시겠습니까?'),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText('취소'),
                  onPressed: () => Navigator.pop(context),
                ),
                PlatformDialogAction(
                  child: PlatformText('로그아웃'),
                  onPressed: () {
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    authProvider.signOut();
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, ModalRoute.withName(Routes.login));
                  },
                )
              ],
            ));
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "개인정보보호정책",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "서비스이용약관",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://blog.naver.com/greediteam/222525122976',  // apple: https://blog.naver.com/greediteam/222525122976 google: https://blog.naver.com/greediteam/222629788970
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}