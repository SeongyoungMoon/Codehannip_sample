
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'detector_painters.dart';

Widget _buildResults(dynamic _scanResults, CameraController _camera) {
  const Text noResultsText = const Text('No results!');

  if (_scanResults == null ||
      _camera == null ||
      !_camera.value.isInitialized) {
    return noResultsText;
  }

  CustomPainter painter;

  final Size imageSize = Size(
    _camera.value.previewSize.height,
    _camera.value.previewSize.width,
  );
      //if (_scanResults is! VisionText) return noResultsText;
      painter = null;//TextDetectorPainter(imageSize, _scanResults);

  return CustomPaint(
    painter: painter,
  );
}

Widget buildImage(dynamic _scanResults, CameraController _camera) {
  return Container(
    constraints: const BoxConstraints.expand(),
    child: _camera == null
        ? const Center(
      child: Text(
        'Initializing Camera...',
        style: TextStyle(
          color: Colors.green,
          fontSize: 30.0,
        ),
      ),
    )
        : Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CameraPreview(_camera),
        _buildResults(_scanResults, _camera),
      ],
    ),
  );
}