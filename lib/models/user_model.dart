class UserModel {
  String uid;
  String fcmToken;
  String nickname;
  String email;
  String name;
  String phoneNum;

  List<dynamic> skipTuto;
  Map<dynamic, dynamic> projectRecords;
  Map<dynamic, dynamic> conceptProgress;
  Map<dynamic, dynamic> projectProgress;
  Map<dynamic, dynamic> themeProgress;

  UserModel({
    this.uid,
    this.fcmToken,
    this.nickname,
    this.email,
    this.name,
    this.phoneNum,
    this.skipTuto,
    this.projectRecords,
    this.conceptProgress,
    this.projectProgress,
    this.themeProgress,
  });

  UserModel copyWith({
    String uid,
    String fcmToken,
    String nickname,
    String email,
    String name,
    String phoneNum,
    List<dynamic> skipTuto,
    Map<dynamic, dynamic> projectRecords,
    Map<dynamic, dynamic> conceptProgress,
    Map<dynamic, dynamic> projectProgress,
    Map<dynamic, dynamic> themeProgress,

  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fcmToken: fcmToken ?? this.fcmToken,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNum: phoneNum ?? this.phoneNum,
      skipTuto: skipTuto ?? this.skipTuto,
      projectRecords: projectRecords ?? this.projectRecords,
      conceptProgress: conceptProgress ?? this.conceptProgress,
      projectProgress: projectProgress ?? this.projectProgress,
      themeProgress: themeProgress ?? this.themeProgress,
    );
  }

  factory UserModel.fromDs(dynamic ds) {
    /*if (ds != null) {
      return UserModel(
          uid: ds.data()['uid'] ?? "",
          fcmToken: ds.data()['fcmToken'] ?? "",
          nickname: ds.data()['nickname'] ?? "",
          email: ds.data()['email'] ?? "",
          name: ds.data()['name'] ?? "",
          phoneNum: ds.data()['phoneNum'] ?? "",
          skipTuto: List.from(ds.data()['skipTuto']) ?? [],
          projectRecords: Map.from(ds.data()['projectRecords'] ?? {}),
          conceptProgress: Map.from(ds.data()['conceptProgress'] ?? {}),
          projectProgress: Map.from(ds.data()['projectProgress'] ?? {})
      );
    } else {
      return UserModel.nullUser();
    }*/

    if (ds != null) {
      print(ds.toString());
      return UserModel(
          uid: ds['uid'] ?? "",
          fcmToken: ds['fcmToken'] ?? "",
          nickname: ds['nickname'] ?? "",
          email: ds['email'] ?? "",
          name: ds['name'] ?? "",
          phoneNum: ds['phoneNum'] ?? "",
          skipTuto: List.from(ds['skipTuto']) ?? [],
          projectRecords: Map.from(ds['projectRecords'] ?? {}),
          conceptProgress: Map.from(ds['conceptProgress'] ?? {}),
          projectProgress: Map.from(ds['projectProgress'] ?? {}),
          themeProgress: Map.from(ds['themeProgress'] ?? {}),
      );
    } else {
      return UserModel.nullUser();
    }
  }

  factory UserModel.nullUser() {
    return UserModel(
      uid: '',
      fcmToken: '',
      nickname: '',
      email: '',
      name: '',
      phoneNum: '',
      skipTuto: [],
      projectRecords: {},
      conceptProgress: {},
      projectProgress: {},
    );
  }

  factory UserModel.anonymousUser(String uid) {
    return UserModel(
      uid: uid,
      fcmToken: '',
      nickname: '',
      email: '',
      name: '',
      phoneNum: '',
      skipTuto: [],
      projectRecords: {},
      conceptProgress: {},
      projectProgress: {},
      themeProgress: {},
    );
  }

  void setFcmToken({String fcmToken}) {
    this.fcmToken = fcmToken ?? this.fcmToken;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fcmToken': fcmToken,
      'nickname': nickname,
      'email': email,
      'name': name,
      'phoneNum': phoneNum,
      'skipTuto': skipTuto,
      'projectRecords': projectRecords,
      'conceptProgress': conceptProgress,
      'projectProgress': projectProgress,
      'themeProgress' : themeProgress,
    };
  }
}
