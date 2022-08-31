//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Paints rectangles around all the text in the image.
class TextDetectorPainter extends CustomPainter {
  //TextDetectorPainter(this.imageSize, this.visionText);

  //final Size imageSize;
  //final VisionText visionText;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    /*Rect _getRect(TextContainer container) {
      return _scaleRect(
        rect: container.boundingBox,
        imageSize: imageSize,
        widgetSize: size,
      );
    }*/

    /*for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          paint.color = Colors.green;
          canvas.drawRect(_getRect(element), paint);
        }

        paint.color = Colors.yellow;
        canvas.drawRect(_getRect(line), paint);
      }

      paint.color = Colors.red;
      canvas.drawRect(_getRect(block), paint);
    }*/
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return null;/*oldDelegate.imageSize != imageSize ||
        oldDelegate.visionText != visionText;*/
  }
}

Rect _scaleRect({
  @required Rect rect,
  @required Size imageSize,
  @required Size widgetSize,
}) {
  final double scaleX = widgetSize.width / imageSize.width;
  final double scaleY = widgetSize.height / imageSize.height;

  return Rect.fromLTRB(
    rect.left.toDouble() * scaleX,
    rect.top.toDouble() * scaleY,
    rect.right.toDouble() * scaleX,
    rect.bottom.toDouble() * scaleY,
  );
}