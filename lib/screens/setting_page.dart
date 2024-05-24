import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dyscalculia_app/screens/home_page.dart';

class Setting extends StatelessWidget {
  final TextEditingController noticeController = TextEditingController();
  final TextEditingController arrayController = TextEditingController();
  final TextEditingController rulerController = TextEditingController();
  final TextEditingController missingController = TextEditingController();
  final TextEditingController chanceController = TextEditingController();

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notice = prefs.getString('notice') ?? '';
    int goalArray = prefs.getInt('goalArray') ?? 20;
    int goalRuler = prefs.getInt('goalRuler') ?? 20;
    int goalMissing = prefs.getInt('goalMissing') ?? 20;
    int chance = prefs.getInt('chance') ?? 3;

    noticeController.text = notice;
    arrayController.text = goalArray.toString();
    rulerController.text = goalRuler.toString();
    missingController.text = goalMissing.toString();
    chanceController.text = chance.toString();
  }

  @override
  Widget build(BuildContext context) {
    _loadSettings();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            iconSize: 40,
            icon: Icon(
              Icons.arrow_back,
              size: 40, // 아이콘 색상 설정
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
            },
            padding: EdgeInsets.all(10.0), // 터치 영역 설정
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView( // Scroll view to handle keyboard appearance
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                  child: TextField(
                    controller: noticeController,
                    decoration: InputDecoration(
                      labelText: '안내장',
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
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0), // 외부 패딩 지정
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton( //Submit
                          onPressed: () async {
                            String notice = noticeController.text;
                            if (notice.isNotEmpty) {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('notice', notice);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('저장되었습니다.')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            //배경색
                            foregroundColor: Colors.white,
                            //글씨색
                            shadowColor: Colors.black,
                            //그림자색
                            elevation: 5,
                            //그림자 깊이
                            surfaceTintColor : Colors.transparent,

                            padding: EdgeInsets.all(20.0),
                            //버튼 내 여백
                            //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(
                              '안내장 설정',
                              style: TextStyle(
                                fontFamily: 'static',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 40,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                  child: Divider(height: 0, color: Colors.grey, thickness: 2.0,),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                  child: Column(
                    children: <Widget>[
                      _buildGoalInputField(arrayController, '수 위치 찾기 목표 문제 수'),
                      _buildGoalInputField(rulerController, '눈금 수 찾기 목표 문제 수'),
                      _buildGoalInputField(missingController, '사라진 수 찾기 목표 문제 수'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 00.0),
                  child: Text(
                    '목표 문제 수의 최소값은 1입니다',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'static',
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10), // 외부 패딩 지정
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton( //Submit
                          onPressed: () async {
                            int goalArray = int.tryParse(arrayController.text) ?? 1;
                            int goalRuler = int.tryParse(rulerController.text) ?? 1;
                            int goalMissing = int.tryParse(missingController.text) ?? 1;

                            // 유효성 검사
                            goalArray = goalArray < 1 ? 1 : goalArray;
                            goalRuler = goalRuler < 1 ? 1 : goalRuler;
                            goalMissing = goalMissing < 1 ? 1 : goalMissing;

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('goalArray', goalArray);
                            await prefs.setInt('goalRuler', goalRuler);
                            await prefs.setInt('goalMissing', goalMissing);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('저장되었습니다.')),
                            );

                            // 텍스트 필드 갱신
                            arrayController.text = goalArray.toString();
                            rulerController.text = goalRuler.toString();
                            missingController.text = goalMissing.toString();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            //배경색
                            foregroundColor: Colors.white,
                            //글씨색
                            shadowColor: Colors.black,
                            //그림자색
                            elevation: 5,
                            //그림자 깊이
                            surfaceTintColor : Colors.transparent,

                            padding: EdgeInsets.all(20.0),
                            //버튼 내 여백
                            //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(
                              '목표 설정',
                              style: TextStyle(
                                fontFamily: 'static',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 40,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                  child: Divider(height: 0, color: Colors.grey, thickness: 2.0,),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
                  child: TextField(
                    controller: chanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '문제 풀기 시도 기회',
                      labelStyle: TextStyle(
                        fontFamily: 'static',
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                    style: TextStyle(
                      fontFamily: 'static',
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 00.0),
                  child: Text(
                    '기회의 최소값은 1, 최대값은 3입니다',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'static',
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10), // 외부 패딩 지정
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton( //Submit
                          onPressed: () async {
                            int chance = int.tryParse(chanceController.text) ?? 1;

                            // 유효성 검사
                            if (chance < 1) chance = 1;
                            if (chance > 3) chance = 3;

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('chance', chance);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('저장되었습니다.')),
                            );

                            // 텍스트 필드 갱신
                            chanceController.text = chance.toString();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            //배경색
                            foregroundColor: Colors.white,
                            //글씨색
                            shadowColor: Colors.black,
                            //그림자색
                            elevation: 5,
                            //그림자 깊이
                            surfaceTintColor : Colors.transparent,

                            padding: EdgeInsets.all(20.0),
                            //버튼 내 여백
                            //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(
                              '기회 설정',
                              style: TextStyle(
                                fontFamily: 'static',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 40,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
          fontWeight: FontWeight.w500,
          fontSize: 30.0,
        ),
      ),
    );
  }
}
