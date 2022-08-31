import 'dart:async';

//import 'package:apple_sign_in/apple_sign_in.dart'; //todo: appleSignIn
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/services/firestore_path.dart';
import 'package:code_hannip/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

enum Status {
  Uninitialized,
  AnoAuthenticating,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering,
  Logout
}

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;
  SignInWithApple _appleSignIn;
  //FacebookLogin _facebookLogin;

  //Firestore object
  final _firestoreService = FirestoreService.instance;

  //FCM object
  FirebaseMessaging fcm = FirebaseMessaging.instance;

  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<User> get user =>
      _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    //_appleSignIn = SignInWithApple();

    //_facebookLogin = FacebookLogin();
    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Create user object based on the given FirebaseUser
  User _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return user;
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      ///로그아웃 했음
      if (_status == Status.Uninitialized) {
        await Future.delayed(Duration(seconds: 3));
        _status = Status.Unauthenticated;
        notifyListeners();
      }
    } else {
      if (_status == Status.Uninitialized) {
        ///Auth는 있고, 자동로그인하는 시점
        ///setUser
        await Future.delayed(Duration(seconds: 3));
        //InAppPurchaseConnection.enablePendingPurchases();

        ///익명로그인인지 판단
        await _firestoreService
            .getData(path: FirestorePath.user(firebaseUser.uid))
            .then((ds) => ds.exists
                ? UserProvider.setUser(firebaseUser.uid)
                : UserProvider.setAnonymouseUser(UserModel(
                    uid: firebaseUser.uid,
                    name: 'guest',
                    nickname: 'guest',
                    skipTuto: [false, false],
                    fcmToken: '',
                    email: 'guest@guest.com',
                    phoneNum: '0100000000',
                    projectRecords: {},
                    conceptProgress: {},
                    projectProgress: {},
                    themeProgress: {},
        )));


        var wadizEnd, wadizStart;
        print("여ㅕㅕㅇ기ㅣㅣㅣ");
        print(firebaseUser.email);
        print(firebaseUser.uid);
        await Future.delayed(Duration(seconds: 3));
        if (firebaseUser.email != ""){
          await _firestoreService
              .getData(path: 'Wadiz/${firebaseUser.email}')
              .then((ds) async {
            if(ds.exists) {
              wadizStart = await getWadizStart(firebaseUser.email);
              wadizEnd = await getWadizEnd(firebaseUser.email);
            }
          });
          ProviderModel.wadizStartSet(wadizStart);
          ProviderModel.wadizEndSet(wadizEnd);
          var now = DateTime.now();
          if(wadizEnd != null){
            if(now.isAfter(wadizEnd)){
              ProviderModel.wadizStatic(false);
              print("Wadiz funding is over!");
            } else {
              ProviderModel.wadizStatic(true);
            }
          }
          print("setuser1");
        }


        _status = Status.Authenticated;
        notifyListeners();
      } else if (_status == Status.AnoAuthenticating) {
        ///익명로그인 시도
        var _user = UserModel(
            uid: firebaseUser.uid,
            name: 'guest',
            nickname: 'guest',
            skipTuto: [false, false],
            fcmToken: '',
            email: 'guest@guest.com',
            phoneNum: '0100000000',
            projectRecords: {},
            conceptProgress: {},
            projectProgress: {},
            themeProgress: {});
        UserProvider.setAnonymouseUser(_user);
      } else {
        ///Authenticating
        ///Registering 체크
        ///

        if (_status == Status.Registering) {
          ///회원가입
//          await Future.delayed(Duration(seconds: 3));
          print(232323);
          await UserProvider.setUser(firebaseUser.uid);
          _status = Status.Authenticated;
          notifyListeners();
        } else {
          ///로그인
          await Future.delayed(Duration(seconds: 1));

          var wadizEnd, wadizStart;
          await _firestoreService
              .getData(path: FirestorePath.wadiz(firebaseUser.email))
              .then((ds) async {
            if(ds.exists) {
              wadizStart = await getWadizStart(firebaseUser.email);
              wadizEnd = await getWadizEnd(firebaseUser.email);
            }
          });
          ProviderModel.wadizStartSet(wadizStart);
          ProviderModel.wadizEndSet(wadizEnd);
          var now = DateTime.now();
          if(wadizEnd != null){
            if(now.isAfter(wadizEnd)){
              ProviderModel.wadizStatic(false);
              print("Wadiz funding is over!");
            } else {
              ProviderModel.wadizStatic(true);
            }
          }
          print("setuser2, login");
          await UserProvider.updateUser(firebaseUser.uid);
          print("asdf");
          print(ProviderModel.isWadizzz());
          _status = Status.Authenticated;
          notifyListeners();
        }

        ///updateUser
      }

//      ///익명로그인
//      await UserUtil.setUser(await _firestoreService
//          .getData(path: FirestorePath.user(firebaseUser.uid))
//          .then((ds) => ds.exists
//              ? UserModel.fromDs(ds.data)
//              : UserModel(
//                  uid: firebaseUser.uid,
//                  name: 'guest',
//                  nickname: 'guest',
//                  skipTuto: [false, false],
//                  fcmToken: '',
//                  email: 'guest@guest.com',
//                  phoneNum: '0100000000',
//                  projectRecords: {})));

    }
  }

  Future<DateTime> getWadizEnd(String email) async {
    var wadizEnd = DateTime.now();

    await _firestoreService.getData(path: FirestorePath.wadiz(email)).then((value) =>
    wadizEnd = value.data()['until'].toDate()
    );

    return wadizEnd;
  }
  Future<DateTime> getWadizStart(String email) async {
    var wadizStart = DateTime.now();

    await _firestoreService.getData(path: FirestorePath.wadiz(email)).then((value) =>
    wadizStart = value.data()['register'].toDate()
    );

    return wadizStart;
  }

  //새로운 유저 이메일 로그인 메소드
  Future<String> registerWithEmailAndPassword({
    String email,
    String password,
    String nickname,
    String name,
    String phoneNum,
  }) async {
    try {
      _status = Status.Registering;
      notifyListeners();

      var sameNickName = await _firestoreService
          .collectionStream(
              path: FirestorePath.users(),
              builder: (data, documentId) => UserModel.fromDs(data),
              queryBuilder: (q) => (q.where('nickname', isEqualTo: nickname)))
          .elementAt(0);
      if (sameNickName.isNotEmpty) {
        return "중복 닉네임";
      }

      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(result.user);
      var _user = UserModel(
        uid: result.user.uid,
        fcmToken: await fcm.getToken(),
        email: email,
        name: name,
        nickname: nickname,
        phoneNum: phoneNum,
        skipTuto: [false, false],
        projectRecords: {},
        conceptProgress: {},
        projectProgress: {},
        themeProgress: {},
      );

      await _firestoreService.setData(
          path: FirestorePath.user(result.user.uid), data: _user.toMap());

      //여기서부터 와디즈
      //login시 wadizSixMonthsLater를 불러와서 현재시각보다 후면 sub유지해줌
      var wadizUsers = [];
      await _firestoreService.getData(path: FirestorePath.wadiz('firstFunding')).then((value) =>
        wadizUsers = value.data()['Users']
      );

      if(wadizUsers.contains(email)){
        print("This user funded Wadiz");
        var wadizUserStart = DateTime.now();
        var wadizSixMonthsLater = wadizUserStart.add(Duration(days: 183));

        await _firestoreService.setData(
            path: FirestorePath.wadiz(email), data: {
          'register': wadizUserStart,
          'until': wadizSixMonthsLater,
          'email': email,
        }
        );

        return "와디즈";
      }

      _status = Status.Authenticated;
      notifyListeners();
      return "성공";
    } catch (e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return e.toString();
    }
  }

  //Method to handle user sign in anonymously
  Future<bool> signInWithAnonymous() async {
    try {
      _status = Status.AnoAuthenticating;
      notifyListeners();
      await _auth.signInAnonymously();
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      var credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = credential.user;
      final snapshot =
          await _firestoreService.getData(path: FirestorePath.user(user.uid));

      ///재로그인 시 와디즈 확인 코드
      var wadizEnd, wadizStart;
      await _firestoreService
          .getData(path: FirestorePath.wadiz(user.email)) //firebaseuser -> user
          .then((ds) async {
        if(ds.exists) {
          wadizStart = await getWadizStart(user.email); //firebaseuser -> user
          wadizEnd = await getWadizEnd(user.email); //firebaseuser -> user
        }
      });
      ProviderModel.wadizStartSet(wadizStart);
      ProviderModel.wadizEndSet(wadizEnd);
      var now = DateTime.now();
      if(wadizEnd != null){
        if(now.isAfter(wadizEnd)){
          ProviderModel.wadizStatic(false);
          print("Wadiz funding is over!");
        } else {
          ProviderModel.wadizStatic(true);
        }
      }

      if (snapshot != null && snapshot.exists) {
        ///유저 다큐먼트 있을 때
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      } else {
        ///유저 다큐먼트 없을 때
        _status = Status.Unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future<bool> signInWithApple() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      if (await SignInWithApple.isAvailable()) {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        var authResult = await _auth.signInWithCredential(oauthCredential);
        var fUser = await authResult.user;

        final snapshot = await _firestoreService.getData(
            path: FirestorePath.user(fUser.uid));

        if (snapshot != null && snapshot.exists) {
          ///유저 다큐먼트 있을 때
          _status = Status.Authenticated;
          await notifyListeners();
        } else {
          ///유저 다큐먼트 없을 때
          ///
          var _user = await UserModel(
            uid: fUser.uid,
            fcmToken: await fcm.getToken(),
            email: fUser.providerData[0].email,
            nickname: '',
            name: '',
            phoneNum: '',
            skipTuto: [false, false],
            projectRecords: {},
            conceptProgress: {},
            projectProgress: {},
            themeProgress: {},
          );
          await _firestoreService.setData(
              path: FirestorePath.user(fUser.uid), data: _user.toMap());
          _status = Status.Authenticated;
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }


    //return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  /*Future<bool> signInWithFacebook() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final result = await _facebookLogin.logIn(['email', 'public_profile']);

      final credential = await FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token);

      var authResult = await _auth.signInWithCredential(credential);

      var fUser = await authResult.user;
      final snapshot =
          await _firestoreService.getData(path: FirestorePath.user(fUser.uid));
      if (snapshot != null && snapshot.exists) {
        ///유저 다큐먼트 있을 때
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      } else {
        ///유저 다큐먼트 없을 때
        var _user = await UserModel(
          uid: fUser.uid,
          fcmToken: await fcm.getToken(),
          email: fUser.email,
          nickname: '',
          name: fUser.displayName,
          phoneNum: fUser.phoneNumber,
          skipTuto: [false, false],
          projectRecords: {},
          conceptProgress: {},
          projectProgress: {},
        );

        await _firestoreService.setData(
            path: FirestorePath.user(fUser.uid), data: _user.toMap());
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }*/

  Future<bool> signInWithGoogle() async {
    print("여기 들어오긴 해?");
    try {
      print("0하ㅏ하하하하하ㅏ");
      _status = Status.Authenticating;
      print("00하ㅏ하하하하하ㅏ");
      notifyListeners();
      print("1111");

      ///생성
      final googleUser = await _googleSignIn
          .signIn()
          .catchError((e) => print("여기 에러임 ㅇㅇ,,,!!!!!!!  $e"));
      print("2222");
      final googleAuth = await googleUser.authentication
          .catchError((e) => print("여기 에러뜨면ㅇ 어캄 $e"));
      print("3333");
      final credential = await GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      print("4444");
      await _auth.signInWithCredential(credential);
      print("5555");
      var fUser = getUser();
      print(fUser.toString());
      print(fUser.providerData[0].email);
      print(fUser.metadata);
      print("이것은 이메일이다 ${fUser.email}");
      print("${fUser.emailVerified}");
      print("6666");
      final snapshot =
          await _firestoreService.getData(path: FirestorePath.user(fUser.uid));
      print("if 전입니다.");


      if (snapshot != null && snapshot.exists) {
        ///유저 다큐먼트 있을 때
        _status = Status.Authenticated;
        notifyListeners();
        print("User Email ${fUser.email}");
        return true;
      } else {
        ///유저 다큐먼트 없을 때
        var _user = await UserModel(
          uid: fUser.uid,
          fcmToken: await fcm.getToken(),
          email: fUser.providerData[0].email,
          nickname: '',
          name: fUser.displayName,
          phoneNum: fUser.phoneNumber,
          skipTuto: [false, false],
          projectRecords: {},
          conceptProgress: {},
          projectProgress: {},
          themeProgress: {},
        );

        var wadizUsers;

        await _firestoreService.getData(path: FirestorePath.wadiz('firstFunding')).then((value) =>
            wadizUsers = value.data()['Users']
    );

        await _firestoreService.setData(
            path: FirestorePath.user(fUser.uid), data: _user.toMap());
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<UserModel> joinUser(String uid, String email, String name) {
    var user = UserModel(
        uid: uid,
        email: email,
        name: name,
        fcmToken: "",
        skipTuto: [false, false],
        projectRecords: {},
        conceptProgress: {},
        projectProgress: {},
        themeProgress: {});

    return _firestoreService.setData(
        path: FirestorePath.user(user.uid), data: user.toMap());
  }

  //todo: no longer return future value
  User getUser() {
    return (_auth.currentUser);
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future signOut() async {
    await _googleSignIn.signOut();
    //await _facebookLogin.logOut();
    await _auth.signOut();
    _status = Status.Unauthenticated;
    ProviderModel.wadizStatic(false);
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future sendPasswordResetEmailByKorean() async {
    await _auth.setLanguageCode("ko");
    await _auth.sendPasswordResetEmail(email: getUser().email);
  }

}
