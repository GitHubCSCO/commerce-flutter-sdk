import 'dart:ui';
import 'dart:ui' as ui;

import 'package:commerce_flutter_sdk/src/features/presentation/helper/barcode_scanner/painters/coordinates_translator.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(this.barcodes, this.imageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size imageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = Color(0x99000000);

    for (final Barcode barcode in barcodes) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));
      builder.addText('${barcode.displayValue}');
      builder.pop();

      final left = translateX(
          barcode.boundingBox.left, size, imageSize, rotation.rawValue);
      final top = translateY(
          barcode.boundingBox.top, size, imageSize, rotation.rawValue);
      final right = translateX(
          barcode.boundingBox.right, size, imageSize, rotation.rawValue);

      final List<Offset> cornerPoints = <Offset>[];
      for (final point in barcode.cornerPoints) {
        final double x =
            translateX(point.x.toDouble(), size, imageSize, rotation.rawValue);
        final double y =
            translateY(point.y.toDouble(), size, imageSize, rotation.rawValue);

        cornerPoints.add(Offset(x, y));
      }

      // Add the first point to close the polygon
      cornerPoints.add(cornerPoints.first);
      canvas.drawPoints(PointMode.polygon, cornerPoints, paint);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: (right - left).abs(),
          )),
        Offset(left, top),
      );
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
