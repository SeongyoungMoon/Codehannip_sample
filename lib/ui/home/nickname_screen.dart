import 'package:code_hannip/models/user_model.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/firestore_path.dart';
import 'package:code_hannip/services/firestore_service.dart';
import 'package:code_hannip/ui/home/first_screen.dart';
import 'package:flutter/material.dart';

import 'bottombar.dart';

class NicknameScreen extends StatefulWidget {
  @override
  _NicknameScreenState createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "코드한입에 오신것을\n환영합니다!\n사용자 본인의 닉네임을\n설정해주세요.",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 8.0),
            Text(
              "닉네임은 변경 불가능합니다.",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nicknameController,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(14.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: '닉네임',
              ),
            ),
          ],
        ),
        actions: [
          RaisedButton(
              child: Text('완료'),
              onPressed: () async {
                if (_nicknameController.text.isEmpty) {
                  ///빈칸 입력으로 인해 다시 입력 받기
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "닉네임을 입력해주세요.",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          actions: [
                            RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("확인"))
                          ],
                        );
                      });
                } else {
                  var list = await FirestoreService.instance
                      .collectionStream(
                          path: FirestorePath.users(),
                          builder: (data, documentId) => UserModel.fromDs(data),
                          queryBuilder: (q) => (q.where('nickname',
                              isEqualTo: _nicknameController.text)))
                      .elementAt(0);
                  if (list.isNotEmpty) {
                    ///중복으로 인해 다시 입력 받기
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "중복되는 닉네임이 있습니다.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            actions: [
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"))
                            ],
                          );
                        });
                    await _nicknameController.clear();
                  } else {
                    ///유저 업데이트
                    var user = UserProvider.getUser();
                    user.nickname = _nicknameController.text;
                    await FirestoreService.instance.setData(
                        path: FirestorePath.user(user.uid), data: user.toMap());
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            //builder: (BuildContext context) => FirstScreen()));
                              builder: (BuildContext context) => BottomBarMainScreen(0)));
                  }
                }
              })
        ],
      ),
    );
  }
}
