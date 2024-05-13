import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color borderColor;
  final double strokeWidth;

  const BorderedText({
    Key? key,
    required this.text,
    required this.textStyle,
    this.borderColor = Colors.black,
    this.strokeWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Text border
        Text(
          text,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = borderColor,
          ),
        ),
        // Text fill
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
