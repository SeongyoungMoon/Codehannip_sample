import 'package:code_hannip/constants/app_font_family.dart';
import 'package:code_hannip/models/example_model.dart';
import 'package:code_hannip/providers/example_provider.dart';
import 'package:code_hannip/utils/db_string_converter.dart';
import 'package:code_hannip/widgets/doing_dialog.dart';
import 'package:code_hannip/widgets/done_dialog.dart';
import 'package:code_hannip/widgets/extended_fab.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:code_hannip/services/data_repository/user_repository.dart';
import 'package:code_hannip/providers/user_provider.dart';
import 'package:code_hannip/models/concept_model.dart';
import 'package:code_hannip/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class QuizExampleScreen extends StatefulWidget {
  final String title;
  final int length;
  final ConceptModel concept;

  QuizExampleScreen(this.title, this.length, this.concept);

  @override
  _QuizExampleScreenState createState() => _QuizExampleScreenState();
}

class _QuizExampleScreenState extends State<QuizExampleScreen> {

  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;

  String selectedChoice = "";
  String hint = "";

  ExampleProvider exampleProvider;
  ExampleModel _currentModel;

  String conceptNum;
  int conceptProgress;

  var str;

  @override
  void initState() {
    super.initState();
    exampleProvider = Provider.of<ExampleProvider>(context, listen: false);
    _currentModel = exampleProvider.exampleList[0];
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
  }

  @override
  Widget build(BuildContext context) {
    str = '${_currentModel.problem[0]}';
    str.replaceAll(r'\n', '\n');
    hint = _currentModel.hint;
    return Consumer<ExampleProvider>(
      builder: (_, exampleProvider, __) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0.0,
          title:  Transform(
            transform:  Matrix4.translationValues(10.0, 0.0, 0.0),
            child: Text(
              "${widget.concept.title}",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            /*
          actions: [
            FlatButton(
              child: Icon(
                Icons.lightbulb_outline,
                size: 24.0,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
          ],*/
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _body(),
                    '${str}'=='' ? SizedBox(height: 36.0,) : _codebox(),
                    Container(),
                    //Expanded(child: Container()),
                    _choices(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    _currentModel.level != widget.length ? _doing() : _done()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  Widget _codebox() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal:16.0, vertical: 12.0),
          alignment: Alignment.topLeft,
          child: Text(dbStringConverter('${str}'),
              style: Theme.of(context).textTheme.labelSmall),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondary
              )
          )
      ),
    );
  }


  Widget _body() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              children: [
                SizedBox(height: 10.0),
                _topProgressIndicator(),
              ]
          ),
          SizedBox(width: 16.0),
          Flexible(
              fit: FlexFit.tight,
              child: Text(_currentModel.description,
                  style: Theme.of(context).textTheme.displayLarge)
          ),
        ],
      ),
    );
  }

  Widget _choices() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
              children: List.generate(_currentModel.choices.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (var i = 0; i < _currentModel.choices.length; i++) {
                        _currentModel.choices[i]
                            .update('isSelected', (value) => false);
                      }
                      _currentModel.choices[index]
                          .update('isSelected', (value) => true);
                      selectedChoice =
                          _currentModel.choices[index].values.elementAt(1);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      _currentModel.choices[index].values.elementAt(1),
                      style:
                      _currentModel.choices[index].values.elementAt(0) == true
                          ? Theme.of(context).textTheme.displaySmall
                          : Theme.of(context).textTheme.displayMedium,
                    ),
                    decoration: BoxDecoration(
                      color:
                      _currentModel.choices[index].values.elementAt(0) == true
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                          color:
                          _currentModel.choices[index].values.elementAt(0) == true
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSecondaryContainer
                              .withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          offset: Offset(0, 1.8),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ));
  }

  Widget _doing() {
    return ExtendedFAB(
      title: "정답 확인",
      icon: Icons.check,
      function: () => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return DoingDialog(
                isCorrect:
                selectedChoice == _currentModel.answer ? true : false,
                noChoice: selectedChoice == "",
                hint: hint,
                function: () {
                  if (selectedChoice == _currentModel.answer) {
                    Navigator.pop(context);
                    setState(() {
                      exampleProvider.upLevel(exampleProvider.currentLevel);
                      _currentModel = exampleProvider
                          .exampleList[exampleProvider.currentLevel];
                    });
                  } else {
                    Navigator.pop(context);
                    setState(() {
                      for (var i = 0; i < _currentModel.choices.length; i++) {
                        _currentModel.choices[i]
                            .update('isSelected', (value) => false);
                      }
                      selectedChoice = "";
                    });
                  }
                });
          }),
    );
  }

  Widget _done() {
    return ExtendedFAB(
      title: "정답 확인",
      icon: Icons.check,
      function: () => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return DoneDialog(
                isCorrect:
                selectedChoice == _currentModel.answer ? true : false,
                noChoice: selectedChoice == "",
                hint: hint,
                function: () {
                  if (selectedChoice == _currentModel.answer) {
                    conceptNum = "${widget.concept.stage}-${widget.concept.step}";
                    conceptProgress = UserProvider.getUser().conceptProgress[conceptNum];
                    UserRepository().updateConceptProgress(conceptNum, 2);

                    //여기에서 광고 시작
                    if (_interstitialAd != null) {
                      _interstitialAd.show();
                      _interstitialReady = false;
                      _interstitialAd = null;
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }

                  } else {
                    Navigator.pop(context);
                    setState(() {
                      for (var i = 0; i < _currentModel.choices.length; i++) {
                        _currentModel.choices[i]
                            .update('isSelected', (value) => false);
                      }
                      selectedChoice = "";
                    });
                  }
                });
          }),
    );
  }

  Row _topProgressIndicator() {
    return Row(
      children: <Widget>[
        new CircularPercentIndicator(
          radius: 62.0,
          lineWidth: 8.0,
          percent: _currentModel.level / widget.length,
          center: new Text(_currentModel.title,
              style: TextStyle(fontFamily: AppFontFamily.YANGJIN, fontSize: 22, height: 0.75, color: Theme.of(context).colorScheme.primary)),
          progressColor: Theme.of(context).colorScheme.primary,
        ),


        // LinearPercentIndicator(
        //   lineHeight: MediaQuery.of(context).size.height * .008,
        //   width: MediaQuery.of(context).size.width,
        //   progressColor: Theme.of(context).colorScheme.primary,
        //   percent: _currentModel.level / widget.length,
        //   linearStrokeCap: LinearStrokeCap.butt,
//            backgroundColor: ,),
      ],
    );
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
