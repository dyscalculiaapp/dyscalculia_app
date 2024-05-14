import 'package:flutter/material.dart';
import 'dart:math' as math;

class RulerPainter extends CustomPainter {
  final int startMark;
  final int selectedMark;

  RulerPainter({required this.startMark, required this.selectedMark});

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final markWidth = size.width / 15;
    final baseMarkHeight = size.height / 2;
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );


    // 화살표 그리기
    final arrowPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8;

    final arrowX = markWidth * (selectedMark - startMark) + markWidth / 2;
    final arrowBodyStart = 0.0; // 화살표 몸통 시작 지점
    final arrowHeadLength = 20.0;
    final arrowBodyEnd = baseMarkHeight + arrowHeadLength * math.sin(math.pi / 4); // 몸통 끝점 조정

    // 화살표 몸통
    canvas.drawLine(
      Offset(arrowX, arrowBodyStart),
      Offset(arrowX, arrowBodyStart + baseMarkHeight - arrowHeadLength * math.cos(math.pi / 4)),
      arrowPaint,
    );

    // 화살표 머리 (삼각형)
    Path path = Path();
// 삼각형의 "바닥"을 현재 위치보다 위쪽으로 설정합니다 (삼각형 꼭대기를 아래로 만듦).
    path.moveTo(arrowX, arrowBodyStart + baseMarkHeight); // 삼각형 꼭대기
    path.lineTo(arrowX - arrowHeadLength * math.cos(math.pi / 4), arrowBodyStart + baseMarkHeight - arrowHeadLength * math.sin(math.pi / 4));
    path.lineTo(arrowX + arrowHeadLength * math.cos(math.pi / 4), arrowBodyStart + baseMarkHeight - arrowHeadLength * math.sin(math.pi / 4));
    path.close();



    canvas.drawPath(path, arrowPaint);

    for (int i = 0; i < 15; i++) {
      final xPosition = markWidth * i + markWidth / 2;
      var markHeight = baseMarkHeight;
      var strokeWidth = basePaint.strokeWidth;

      if ((startMark + i) % 10 == 0) {
        markHeight *= 1.0;
        strokeWidth = 3.0;
      } else if ((startMark + i) % 5 == 0) {
        markHeight *= 0.75;
        strokeWidth = 2.5;
      } else {
        markHeight *= 0.5;
        strokeWidth = 2.0;
      }

      final paint = Paint()
        ..color = basePaint.color
        ..strokeWidth = strokeWidth;

      canvas.drawLine(
        Offset(xPosition, arrowBodyStart + baseMarkHeight),
        Offset(xPosition, arrowBodyStart + baseMarkHeight + markHeight),
        paint,
      );

      if ((startMark + i) % 5 == 0 && (startMark + i) != selectedMark) {
        textPainter.text = TextSpan(
          text: '${startMark + i}',
          style: TextStyle(color: Colors.black, fontSize: 20),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(xPosition - textPainter.width / 2, arrowBodyStart + baseMarkHeight + markHeight + 4),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RulerWidget extends StatelessWidget {
  final int startMark;
  final int selectedMark;

  RulerWidget({required this.startMark, required this.selectedMark});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RulerPainter(startMark: startMark, selectedMark: selectedMark),
      child: Container(
        height: 100,
      ),
    );
  }
}
