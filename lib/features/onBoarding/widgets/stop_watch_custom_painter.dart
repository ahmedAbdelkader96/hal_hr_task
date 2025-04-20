import 'dart:math';

import 'package:flutter/material.dart';

class StopWatchCustomPainter extends CustomPainter {
  final double progressAnimation;

  StopWatchCustomPainter({required this.progressAnimation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.square
          ..style = PaintingStyle.stroke;

    //angle
    final angle = -((1.0 - progressAnimation) * 2 * pi);

    //Center Point
    final center = Offset(size.width / 2, size.height / 2);

    //Arc
    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: 2 * size.width,
        height: 2 * size.height,
      ),
      pi * 4,
      angle,
      false,
      paint
        ..color =
            progressAnimation.toDouble() == 0.0
                ? Colors.transparent
                : Colors.amber
        ..style = PaintingStyle.stroke,
    );

    //Calculating Points for thumb
    final xPoint = center.dx + cos(angle) * size.width;
    final yPoint = center.dy + sin(angle) * size.width;

    //Drawing thumb
    canvas.drawCircle(
      Offset(xPoint, yPoint),
      5,
      Paint()
        ..color =
            progressAnimation.toDouble() == 0.0
                ? Colors.transparent
                : Colors.amber.withOpacity(progressAnimation)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
