import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      surfaceTintColor: Colors.transparent,
      elevation: 10.0,
      shadowColor: Colors.black,
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
                    fontFamily: 'static',
                    fontWeight: FontWeight.w900,
                    color: contentTextColor,
                    fontSize: 60.0,
                  ),
                ),
                Positioned(
                  bottom: -15,
                  child: Text(
                    contentText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.transparent,
                      fontFamily: 'text',
                      fontSize: 60.0,
                      decoration: TextDecoration.underline,
                      decorationColor: contentTextColor,
                      decorationStyle: TextDecorationStyle.wavy,
                      decorationThickness: 5.0,
                    ),
                  ),
                ),
                if (actionText != '다시 풀기')
                Positioned(
                  bottom: -5,
                  child: Text(
                    '$correctAnswer의 위치는',
                    style: TextStyle(
                      fontFamily: 'static',
                      color: contentTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
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
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      child: Text(
                        actionText,
                        style: TextStyle(
                          fontFamily: 'static',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 40.0,
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
