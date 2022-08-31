import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/utils/function_util.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/providers/user_provider.dart';

import 'package:code_hannip/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ResultScreen extends StatefulWidget {
  final String progressNum;

  ResultScreen(this.progressNum);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<TextEditingController> controllers = [];
  bool checkAnswer;
  var result;

  var inputList = [];
  var answerList;
  var resultList;

  Map executionStrMap;

  ProjectProvider projectProvider;

  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;


  @override
  void initState() {
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    answerList = projectProvider.projectModel.answerList.entries
        .map((e) => e.value.join(' '))
        .toList();
    resultList = projectProvider.projectModel.resultList.entries
        .map((e) => e.value.join(' ')) //todo: answerList -> resultList
        .toList();
    executionStrMap = projectProvider.projectModel.executionStrMap;
    controllers = List.generate(
        executionStrMap.length, (index) => TextEditingController(text: ''));

    //todo: executionStrMap 안쓸거면 이부분 고쳐야함
    /*for (String key in executionStrMap.keys.toList()..sort()) {
      inputList.add(key.split('.')[1]);
    }*/
    checkAnswer = false;
    MobileAds.instance.initialize().then((InitializationStatus status) {
      print('Initialization done: ${status.adapterStatuses}');
      MobileAds.instance
          .updateRequestConfiguration(RequestConfiguration(
          tagForChildDirectedTreatment:
          TagForChildDirectedTreatment.unspecified))
          .then((value) {
        createInterstitialAd();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery
        .of(context)
        .size;
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    result = answerListColumn(resultList);//todo: 여기넣어놔야하나??
    print(result);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          //leading: Container(),//todo: containter로 가려놨던데 아이콘 넣을까..
          title: Text(
            projectProvider.projectModel.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: ListView(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(3),
                    height:22,
                    width: 77,
                    child: Text(
                      '메인 문제',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Text(
                  projectProvider.projectModel.problem,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: phoneSize.height * 0.05),
                Text(
                  "완성 코드",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      answerListColumn(answerList),
                      // answerListColumn(executionSList),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.secondary),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      "결과보기",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(height: 8.0),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: checkAnswer ? 8.0 : 28.0),
                    child: checkAnswer ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //result
                        result,
                      ],
                    ) :
                    Center(
                    child: Text(
                    'RUN',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        .copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary),
                  ),
                )//todo: 여기 왜 바로 안떠...?...
                    ,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.secondary),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      checkAnswer = true;
                    });
                  },
                ),
                SizedBox(height: 16.0),

                //fab 결과 확인 완료
                checkAnswer==true
                    ? Padding(
                  padding: EdgeInsets.only(top: 36.0),
                  child: ExtendedFAB(
                    icon: Icons.check,
                    title: '결과 확인 완료',
                    function: fabFunction,
                  ),
                )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget answerListColumn(List<dynamic> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          list.length,
          (index) => Text(
                list[index],
                style: Theme.of(context).textTheme.labelSmall,
              )),
    );
  }


  Future<void> fabFunction() async {
    var projectProgress = UserProvider.getUser().projectProgress[widget.progressNum];
    if(projectProgress == null){
      await UserRepository().updateProjectProgress(widget.progressNum, 2);
    }
    //여기서 광고 시
    if (_interstitialAd != null) {
      _interstitialAd.show();
      _interstitialReady = false;
      _interstitialAd = null;
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void createInterstitialAd() {
    _interstitialAd ??= InterstitialAd(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          _interstitialReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          _interstitialAd = null;
          createInterstitialAd();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          createInterstitialAd();
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }
}
