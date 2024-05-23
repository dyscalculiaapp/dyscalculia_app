// setting_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dyscalculia_app/screens/home_page.dart';
import 'package:dyscalculia_app/screens/calendar_page.dart';

class Setting extends StatelessWidget {
  final TextEditingController noticeController = TextEditingController();
  final TextEditingController arrayController = TextEditingController();
  final TextEditingController rulerController = TextEditingController();
  final TextEditingController missingController = TextEditingController();

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notice = prefs.getString('notice') ?? '';
    int goalArray = prefs.getInt('goalArray') ?? 20;
    int goalRuler = prefs.getInt('goalRuler') ?? 20;
    int goalMissing = prefs.getInt('goalMissing') ?? 20;

    noticeController.text = notice;
    arrayController.text = goalArray.toString();
    rulerController.text = goalRuler.toString();
    missingController.text = goalMissing.toString();
  }

  @override
  Widget build(BuildContext context) {
    _loadSettings();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: noticeController,
                      decoration: InputDecoration(
                        labelText: '안내장 입력',
                        labelStyle: TextStyle(
                          fontFamily: 'static',
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      ),
                      maxLines: 6,
                      style: TextStyle(
                        fontFamily: 'static',
                        fontWeight: FontWeight.w400,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(20.0),
                      ),
                      child: Text(
                        '안내장 설정',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 40.0,
                        ),
                      ),
                      onPressed: () async {
                        String notice = noticeController.text;
                        if (notice.isNotEmpty) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('notice', notice);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('안내장이 저장되었습니다.')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    _buildGoalInputField(arrayController, '수 위치 찾기 목표'),
                    _buildGoalInputField(rulerController, '눈금 수 찾기 목표'),
                    _buildGoalInputField(missingController, '사라진 수 찾기 목표'),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(20.0),
                      ),
                      child: Text(
                        '목표 설정',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 40.0,
                        ),
                      ),
                      onPressed: () async {
                        int? goalArray = int.tryParse(arrayController.text);
                        int? goalRuler = int.tryParse(rulerController.text);
                        int? goalMissing = int.tryParse(missingController.text);

                        if (goalArray != null && goalRuler != null && goalMissing != null) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('goalArray', goalArray);
                          await prefs.setInt('goalRuler', goalRuler);
                          await prefs.setInt('goalMissing', goalMissing);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('목표가 저장되었습니다.')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()), // 여백을 차지하여 아이콘 버튼들을 아래로 밀어냄
              Divider(height: 0, color: Colors.grey, thickness: 2.0,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, size: 45),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      },
                    ),
                  ],
                ),
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
