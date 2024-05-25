import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MYAnswerDialog extends StatelessWidget {
  final String contentText;
  final Color contentTextColor;
  final String actionText;
  final VoidCallback onActionPressed;
  final int correctAnswer;


  MYAnswerDialog({
    Key? key,
    required this.contentText,
    required this.contentTextColor,
    required this.actionText,
    required this.onActionPressed,
    required String correctAnswerString,
  }) : correctAnswer = int.tryParse(correctAnswerString) ?? -1,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      surfaceTintColor: Colors.transparent,
      elevation: 10.0,
      shadowColor: Colors.black,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 다이얼로그 크기를 최소화
          children: [
            SizedBox(height: 40.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  contentText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'static',
                    fontWeight: FontWeight.w900,
                    color: contentTextColor,
                    fontSize: 50.sp,
                  ),
                ),
                Positioned(
                  bottom: -10.h,
                  child: Text(
                    contentText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.transparent,
                      fontFamily: 'static',
                      fontSize: 50.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: contentTextColor,
                      decorationStyle: TextDecorationStyle.wavy,
                      decorationThickness: 3.r,
                    ),
                  ),
                ),
                if (actionText != '다시 풀기')
                  Positioned(
                    bottom: 10.h,
                    child: Text(
                      '답은 $correctAnswer입니다',
                      style: TextStyle(
                        fontFamily: 'static',
                        color: contentTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp,
                      ),
                    ),
                  ),
              ],
            ),
            if (actionText != '다시 풀기')
              SizedBox(height: 40.h),
            SizedBox(height: 30.h),// 간격 조절
            Padding(
              padding: EdgeInsets.all(15.r), // 외부 패딩 지정
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onActionPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                      ),
                      child: Text(
                        actionText,
                        style: TextStyle(
                          fontFamily: 'static',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
