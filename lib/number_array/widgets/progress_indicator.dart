import 'package:flutter/material.dart';
import 'package:dyscalculia_app/number_array/widgets/borderd_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProgressIndicator extends StatelessWidget {
  final int totalProblem;
  final int solvedProblem;
  final double minHeight;
  final Color color;
  final Color backgroundColor;
  final Color valueColor;

  const MyProgressIndicator({
    Key? key,
    required this.totalProblem,
    required this.solvedProblem,
    this.minHeight = 20.0,
    this.color = Colors.blueGrey,
    this.backgroundColor = Colors.blue,
    this.valueColor = const Color(0xFF4993FA),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressValue = totalProblem > 0 ? solvedProblem / totalProblem : 0.0;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(minHeight),
          child: LinearProgressIndicator(
            minHeight: minHeight,
            value: progressValue,
            backgroundColor: backgroundColor,
            color: color,
            valueColor: AlwaysStoppedAnimation(valueColor),
          ),
        ),
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: BorderedText(
                  text: '푼 문제 ${solvedProblem}',
                  textStyle: TextStyle(
                    fontFamily: 'static',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                  borderColor: valueColor,
                  strokeWidth: 5.r,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: BorderedText(
                  text: '남은 문제 ${totalProblem - solvedProblem}',
                  textStyle: TextStyle(
                    fontFamily: 'static',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                  borderColor: valueColor,
                  strokeWidth: 5.r,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

