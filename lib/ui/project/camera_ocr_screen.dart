import 'package:camera/camera.dart';
import 'package:code_hannip/providers/project_provider.dart';
import 'package:code_hannip/ui/project/moving_result_screen.dart';//for kids
import 'package:code_hannip/ui/project/camera_result_screen.dart';
import 'package:code_hannip/utils/scan_util.dart';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraOcrScreen extends StatefulWidget {
  @override
  _CameraOcrScreenState createState() => _CameraOcrScreenState();
}

class _CameraOcrScreenState extends State<CameraOcrScreen>
    with WidgetsBindingObserver {
  CameraController _camera;
  bool _isDetecting = false;
  final CameraLensDirection _direction = CameraLensDirection.back;
  /*final TextRecognizer _textRecognizer =
      FirebaseVision.instance.textRecognizer();*/
  ProjectProvider projectProvider;

  @override
  void initState() {
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);

    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _camera.dispose();
    super.dispose();
  }

  void _initializeCamera() async {
    final description = await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
    );

    await _camera.initialize();

    await _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      setState(() {
        _isDetecting = true;
      });
      ScannerUtils.detect(
        image: image,
        //detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
        (results) async {
          if (results != null) {
            await Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider.value(
                          value: projectProvider, child: MovingResultScreen())));
            });
          }
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  /*Future<VisionText> Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _textRecognizer.processImage;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _camera == null
              ? Container(
                  color: Colors.black,
                )
              : Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: CameraPreview(_camera)),
        ],
      ),
    );
  }
}
