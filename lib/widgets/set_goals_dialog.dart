// set_goals_dialog.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetGoalsDialog extends StatelessWidget {
  final TextEditingController arrayController = TextEditingController();
  final TextEditingController rulerController = TextEditingController();
  final TextEditingController missingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 10.0,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60.0),
        side: BorderSide(color: Colors.green, width: 2.0), // 다이얼로그 테두리 색
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(30.0), // 다이얼로그 패딩 추가
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '목표 설정',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'static',
                  fontWeight: FontWeight.w800,
                  fontSize: 50.0,
                ),
              ),
              SizedBox(height: 20),
              _buildGoalInputField(arrayController, '수 위치 찾기'),
              _buildGoalInputField(rulerController, '눈금 수 찾기'),
              _buildGoalInputField(missingController, '사라진 수 찾기'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.0,
                        ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      int? goalArray = int.tryParse(arrayController.text);
                      int? goalRuler = int.tryParse(rulerController.text);
                      int? goalMissing = int.tryParse(missingController.text);

                      if (goalArray != null && goalRuler != null && goalMissing != null) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('goalArray', goalArray);
                        await prefs.setInt('goalRuler', goalRuler);
                        await prefs.setInt('goalMissing', goalMissing);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                        '저장',
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.0,
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'static',
            fontWeight: FontWeight.w400,
            fontSize: 20.0,
          ),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // 텍스트 필드 높이 조절
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(  // 텍스트 필드 내부 텍스트 스타일
          fontFamily: 'static',
          fontWeight: FontWeight.w600,
          fontSize: 30.0,
        ),
      ),
    );
  }
}
