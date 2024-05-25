import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    int goalArray = prefs.getInt('goalArray') ?? 10;
    int goalRuler = prefs.getInt('goalRuler') ?? 10;
    int goalMissing = prefs.getInt('goalMissing') ?? 10;
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
            iconSize: 30.r,
            icon: Icon(
              Icons.arrow_back,
              size: 30.r, // 아이콘 색상 설정
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView( // Scroll view to handle keyboard appearance
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                  child: TextField(
                    controller: noticeController,
                    decoration: InputDecoration(
                      labelText: '안내장',
                      labelStyle: TextStyle(
                        fontFamily: 'static',
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                    ),
                    maxLines: 6,
                    style: TextStyle(
                      fontFamily: 'static',
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w), // 외부 패딩 지정
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

                            padding: EdgeInsets.all(15.r),
                            //버튼 내 여백
                            //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                          ),
                          child: Text(
                              '안내장 설정',
                              style: TextStyle(
                                fontFamily: 'static',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 30.sp,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                  child: Divider(height: 0, color: Colors.grey, thickness: 2.0),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                  child: Column(
                    children: <Widget>[
                      _buildGoalInputField(arrayController, '수 위치 찾기 목표 문제 수'),
                      _buildGoalInputField(rulerController, '눈금 수 찾기 목표 문제 수'),
                      _buildGoalInputField(missingController, '사라진 수 찾기 목표 문제 수'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    '목표 문제 수의 최소값은 1입니다',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'static',
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h), // 외부 패딩 지정
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

                            padding: EdgeInsets.all(15.r),
                            //버튼 내 여백
                            //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                          ),
                          child: Text(
                              '목표 설정',
                              style: TextStyle(
                                fontFamily: 'static',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 30.sp,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                  child: Divider(height: 0, color: Colors.grey, thickness: 2.0,),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                  child: TextField(
                    controller: chanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '문제 풀기 시도 기회',
                      labelStyle: TextStyle(
                        fontFamily: 'static',
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                    ),
                    style: TextStyle(
                      fontFamily: 'static',
                      fontWeight: FontWeight.w500,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Text(
                    '기회의 최소값은 1, 최대값은 3입니다',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'static',
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h), // 외부 패딩 지정
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

                            padding: EdgeInsets.all(15.r),
                            //버튼 내 여백
                            //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                          ),
                          child: Text(
                              '기회 설정',
                              style: TextStyle(
                                fontFamily: 'static',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 30.sp,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalInputField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'static',
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
          ),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w), // 텍스트 필드 높이 조절
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(  // 텍스트 필드 내부 텍스트 스타일
          fontFamily: 'static',
          fontWeight: FontWeight.w500,
          fontSize: 30.sp,
        ),
      ),
    );
  }
}
