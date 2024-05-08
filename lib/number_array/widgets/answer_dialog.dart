import 'package:flutter/material.dart';

class MYAnswerDialog extends StatelessWidget {
  final Color backgroundColor;
  final Color shadowColor;
  final double borderRadius;
  final String contentText;
  final String font;
  final double underlineGap;
  final Color contentTextColor;
  final double contentFontSize;
  final Color underlineColor;
  final double underlineThickness;
  final String actionText;
  final Color actionButtonColor;
  final Color actionTextColor;
  final double actionTextSize;
  final VoidCallback onActionPressed;
  final int correctAnswer;


   MYAnswerDialog({
    Key? key,
    required this.backgroundColor,
    required this.shadowColor,
    this.borderRadius = 20.0,
    required this.contentText,
    required this.font,
    required this.underlineGap,
    required this.contentTextColor,
    required this.contentFontSize,
    required this.underlineColor,
    required this.underlineThickness,
    required this.actionText,
    required this.actionButtonColor,
    required this.actionTextColor,
    required this.actionTextSize,
    required this.onActionPressed,
    required String correctAnswerString,
  }) : correctAnswer = int.tryParse(correctAnswerString) ?? -1,
        super(key: key);


  Widget _buildAnswerGrid(int correctAnswer) {
    int gridSize = 10;
    List<Widget> rows = [];
    for (int i = 0; i < gridSize; i++) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < gridSize; j++) {
        int number = i * gridSize + j + 1;
        rowChildren.add(Padding(
          padding: const EdgeInsets.all(2.0),  // 각 원 주위에 2.0의 패딩 추가
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: number == correctAnswer ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,  // 각 행을 중앙 정렬
        children: rowChildren,
      ));
    }
    return Center(  // 전체 그리드를 중앙에 배치
      child: Column(children: rows),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      surfaceTintColor: Colors.transparent,
      elevation: 10.0,
      shadowColor: shadowColor,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 다이얼로그 크기를 최소화
          children: [
            // 타이틀
            Container(
              height: 60.0, // title의 높이
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(8 * 2 - 1, (index) {
                        if (index % 2 == 0) {
                          return Container(
                            width: 10.0,
                            height: 100.0,
                            color: Colors.green,
                          );
                        } else {
                          return SizedBox(width: 40.0);
                        }
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(8 * 2 - 1, (index) {
                      if (index % 2 == 0) {
                        return Icon(Icons.circle, size: 40.0, color: Colors.green);
                      } else {
                        return SizedBox(width: 10.0);
                      }
                    }),
                  ),
                ],
              ),
            ),
            if (actionText != '다시 풀기')
              SizedBox(height: 30.0),
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  contentText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: font,
                    color: contentTextColor,
                    fontSize: contentFontSize,
                  ),
                ),
                Positioned(
                  bottom: underlineGap,
                  child: Text(
                    contentText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.transparent,
                      fontFamily: font,
                      fontSize: contentFontSize,
                      decoration: TextDecoration.underline,
                      decorationColor: underlineColor,
                      decorationStyle: TextDecorationStyle.wavy,
                      decorationThickness: underlineThickness,
                    ),
                  ),
                ),
                if (actionText != '다시 풀기')
                Positioned(
                  bottom: underlineGap + 10,
                  child: Text(
                    '$correctAnswer의 위치는',
                    style: TextStyle(
                      fontFamily: font,
                      color: contentTextColor,
                      fontSize: contentFontSize - 20,
                    ),
                  ),
                ),
              ],
            ), // 간격 조절
            if (actionText != '다시 풀기')
              SizedBox(height: 30.0),
            if (actionText != '다시 풀기')
              _buildAnswerGrid(correctAnswer),
            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.all(20.0), // 외부 패딩 지정
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onActionPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: actionButtonColor,
                        foregroundColor: actionTextColor,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: shadowColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      child: Text(
                        actionText,
                        style: TextStyle(
                          fontFamily: font,
                          color: actionTextColor,
                          fontSize: actionTextSize,
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
