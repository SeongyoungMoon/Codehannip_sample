import 'dart:io';

import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../routes.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _resetEmailController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var errorCheck;
  bool _showAppleSignIn;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      setState(() {
        _showAppleSignIn = true;
      });
    } else {
      _showAppleSignIn = false;
    }

    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _resetEmailController = TextEditingController(text: "");
    errorCheck = false;

    var provider = Provider.of<ProviderModel>(context, listen: false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Align(
        alignment: Alignment.center,
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    var phoneSize = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                // Padding(
                //     padding: const EdgeInsets.all(32.0),
                //     child:
                SizedBox(
                      width: phoneSize.width*1,
                      height: phoneSize.width*0.5,
                      child: Image.asset("assets/images/login.png"),
                      ),
                Text(
                  '코드한입에 어서오세요!',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: phoneSize.height * 0.03),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right : 16.0),
                      child: Icon(
                        Icons.mail_outline,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: textFieldForm(
                          _emailController, "아이디를 입력해주세요.", "아이디를 확인해주세요", false),
                    ),
                  ],
                ),
                SizedBox(height: phoneSize.height * 0.008),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right : 16.0),
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: textFieldForm(
                          _passwordController, "비밀번호를 입력해주세요.", "비밀번호를 확인해주세요", true),
                    ),
                  ],
                ),
                SizedBox(height: 2.0),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 40),
                        InkWell(
                          onTap: () {
                            //print("비번 이메일 보내기");
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('비밀번호 재설정 이메일'),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('비밀번호를 다시 재설정하고 싶으시다면, 계정 메일을 입력한 후 확인을 눌러주세요 :)'),
                                    SizedBox(height: 8.0),
                                    textFieldForm(
                                        _resetEmailController, "아이디를 입력해주세요.", "아이디를 확인해주세요", false),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      authProvider.sendPasswordResetEmail(_resetEmailController.text);
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            "비밀번호를 잊어버리셨나요?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ),
                        SizedBox(height: phoneSize.height * 0.02),

                      ],
                    )),
                SizedBox(height: phoneSize.height * 0.05),
                authProvider.status == Status.Authenticating
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ExtendedFAB(
                        bottomPadding: 0.0,
                        icon: null,
                        title: '코드한입 시작하기',
                        function: () async {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context)
                                .unfocus(); //to hide the keyboard - if any
                            var status =
                                await authProvider.signInWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);
                            if (!status) {
                              ScaffoldMessenger.of(context).showSnackBar
                                (SnackBar(content: Text("아이디와 비밀번호를 확인해주세요.")));
                            }
                          }
                          //get wadizEnd
                          var now = DateTime.now();
                          var wadizEnd = await authProvider.getWadizEnd(_emailController.text);
                          var wadizStart = await authProvider.getWadizStart(_emailController.text);
                          provider.wadizStartSetInstance(wadizStart);
                          provider.wadizEndSetInstance(wadizEnd);
                          if(now.isAfter(wadizEnd)){
                            provider.wadiz(false);
                            print("Waidz funding is over!");
                          }
                        },
                      ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.register);
                  },
                  child: Text(
                    "회원 가입하러 가기",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ),
                /*
                FlatButton(
                  child: Text("로그인 없이 시작하기"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                              child: Text('게스트로 참여합니다'),
                            ),
                            content: Text(
                              '게스트로 참여하실 경우,'
                              '\n둘이서 하기, 랭킹 참여,'
                              '\n앱 진행사향 저장 등 일부 기능이'
                              '\n지원되지 않습니다.'
                              '\n\n그래도 진행하시겠습니까?',
                            ),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('로그인 진행')),
                              RaisedButton(
                                onPressed: () async {
                                  var status =
                                      await authProvider.signInWithAnonymous();
                                  if (!status) {
                                    ScaffoldMessenger.of(context).showSnackBar
                                      (SnackBar(content: Text("로그인 실패")));
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text("게스트 진행"),
                              )
                            ],
                          );
                        });
                  },
                ), */
                Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, left: 48.0, right: 48.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Login with", style: Theme.of(context).textTheme.headlineSmall,),
                      circularButton("assets/icons/google_logo.png", () async {
                        await authProvider.signInWithGoogle();
                      }),
                      //todo: facebook / apple login changed

                      /*circularButton("assets/icons/facebook_logo.png",
                          () async {
                        await authProvider
                            .signInWithFacebook()
                            .whenComplete(() => true);
                      }),*/
                      _showAppleSignIn
                          ? circularButton("assets/icons/apple_logo.png",
                              () async {
                              await authProvider
                                  .signInWithApple()
                                  .whenComplete(() => true);
                            })
                          : Container() //todo: appleSignIn
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget circularButton(String image, Future<void> Function() function) {
    var size = MediaQuery.of(context).size.width * 0.12;
    return InkWell(
        child: Container(
          width: size,
          height: size,
          child: Center(
              child: Image.asset(image, width: size * 0.7, height: size * 0.7)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        onTap: function);
  }

  Widget textFieldForm(TextEditingController controller, String labelText,
      String errorText, bool obscure) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            .copyWith(color: Theme.of(context).colorScheme.primary),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              errorCheck = true;
            });
            return errorText;
          } else {
            setState(() {
              errorCheck = false;
            });
            return null;
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            labelText: labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error))),
      ),
    );
  }
}
