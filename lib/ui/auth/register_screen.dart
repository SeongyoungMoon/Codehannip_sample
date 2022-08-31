import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/ui/setting/setting_screen.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController;
  TextEditingController _nicknameController;
  TextEditingController _passwordController;
  TextEditingController _passwordCheckController;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool errorCheck = false;

  void showSnack(String title) {
    final snackbar = SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ));
    scaffoldMessengerKey.currentState.showSnackBar(snackbar);
  }

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<ProviderModel>(context, listen: false);
    _emailController = TextEditingController(text: "");
    _nicknameController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _passwordCheckController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    var phoneSize = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                SizedBox(height: phoneSize.height * 0.06),
                SizedBox(
                      width: phoneSize.width*1,
                      height: phoneSize.width*0.5,
                      child: Image.asset('assets/images/login.png'),
                    ),
                Text(
                  '처음 오신 분이군요!',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: phoneSize.height * 0.04),
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
                          _emailController, "이메일을 입력해주세요.", "아이디를 확인해주세요", false),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right : 16.0),
                      child: Icon(
                        Icons.mail_outline,
                        color: Colors.white, //이건 안 바꿔도 됨! 안 보이게 할려고 일부러 흰색 한거임!
                      ),
                    ),
                    Expanded(
                      child: textFieldForm(
                          _nicknameController, "닉네임을 입력해주세요.", "닉네임을 확인해주세요", false),
                    ),
                  ],
                ),
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right : 16.0),
                      child: Icon(
                        Icons.mail_outline,
                        color: Colors.white, //이건 안 바꿔도 됨! 안 보이게 할려고 일부러 흰색 한거임!
                      ),
                    ),
                    Expanded(
                      child: textFieldForm(_passwordCheckController, "비밀번호를 확인해주세요.",
                          "비밀번호를 확인해주세요", true),
                    ),
                  ],
                ),
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
                            if (_passwordController.text !=
                                _passwordCheckController.text) {
                              ScaffoldMessenger.of(context).showSnackBar
                                (SnackBar(content: Text("비밀번호가 서로 다릅니다.")));
                            } else {
                              var code = await authProvider
                                  .registerWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                                nickname: _nicknameController.text,
                                name: _nicknameController.text,
                              );
                              if (code != "성공") {
                                if (code.contains("invalid-email")) {
                                  ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content: Text("이메일 형식을 확인해주세요.")));
                                } else if (code
                                    .contains("weak-password")) {
                                  ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content: Text("패스워드는 6자리 이상으로 설정해주세요.")));
                                } else if (code
                                    .contains("email-already-in-use")) {
                                  ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content: Text("중복된 이메일입니다.")));
                                } else if (code.contains("중복 닉네임")) {
                                  ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content: Text("중복된 닉네임입니다.")));
                                } else if(code.contains("와디즈")){
                                  var wadizEnd = await authProvider.getWadizEnd(_emailController.text);
                                  var wadizStart = await authProvider.getWadizStart(_emailController.text);

                                  provider.wadiz(true);
                                  provider.wadizStartSetInstance(wadizStart);
                                  provider.wadizEndSetInstance(wadizEnd);
                                } else{
                                  print(code);
                                  ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content: Text(code)));
                                }
                              }
                            }
                          }
                        },
                      ),
                Row(
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
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
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
                            .bodySmall,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 36)
              ],
            ),
          ),
        ));
  }

  Widget circularButton(String image, Future<void> Function() function) {
    return InkWell(
        child: Container(
          width: 50.0,
          height: 50.0,
          child: Center(child: Image.asset(image, width: 24.0, height: 24.0)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.surface,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            suffixIcon: errorCheck
                ? Icon(
                    Icons.warning_amber_rounded,
                    color: Theme.of(context).colorScheme.error,
                  )
                : null,
            labelText: labelText,
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,),
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
