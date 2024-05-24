import 'package:flutter/material.dart';
import 'package:dyscalculia_app/widgets/borderd_text.dart';

class MyProgressIndicator extends StatelessWidget {
  final String label;
  final int totalProblem;
  final int correctProblem;
  final double minHeight;
  final Color color;
  final Color backgroundColor;

  const MyProgressIndicator({
    Key? key,
    required this.totalProblem,
    required this.label,
    required this.correctProblem,
    this.minHeight = 20.0,
    this.color = Colors.blueGrey,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);


  @override

  Widget build(BuildContext context) {
    double progressValue = totalProblem > 0 ? correctProblem / totalProblem : 0.0;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(minHeight),
          child: LinearProgressIndicator(
            minHeight: minHeight,
            value: progressValue,
            backgroundColor: backgroundColor,
            color: color,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: BorderedText(
                  text: label,
                  textStyle: TextStyle(
                    fontFamily: 'static',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                  borderColor: color,
                  strokeWidth: 5.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: BorderedText(
                  text: '$correctProblem',
                  textStyle: TextStyle(
                    fontFamily: 'static',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0,
                  ),
                  borderColor: color,
                  strokeWidth: 5.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
