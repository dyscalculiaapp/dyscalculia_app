//시작 화면
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dyscalculia_app/number_array/screens/set_total_problem_page.dart';
import 'package:dyscalculia_app/number_ruler_scales/screens/set_total_problem_page.dart';
import 'package:dyscalculia_app/number_missing/screens/set_total_problem_page.dart';
import 'package:dyscalculia_app/screens/check_scores_page.dart';
import 'package:dyscalculia_app/screens/setting_page.dart';
import 'package:dyscalculia_app/widgets/notice_dialog.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _notice = '';

  @override
  void initState() {
    super.initState();
    _loadNotice();
  }

  Future<void> _loadNotice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notice = prefs.getString('notice') ?? '안내장이 없습니다.';
    setState(() {
      _notice = notice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      debugShowCheckedModeBanner: false,  // 디버그 배너 제거
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Center(
                  child: Text(
                    '수 감각 훈련',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'static',
                      fontWeight: FontWeight.w900,
                      fontSize: 60.sp,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(15.r),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                      ),
                      child: Text(
                        '수 위치 찾기',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SetTotalProblems_array();
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(15.r),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                      ),
                      child: Text(
                        '눈금 수 찾기',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SetTotalProblems_ruler();
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(15.r),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                      ),
                      child: Text(
                        '사라진 수 찾기',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SetTotalProblems_missing();
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(15.r),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                      ),
                      child: Text(
                        '달성도 확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CheckScores();
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(15.r),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                      ),
                      child: Text(
                        '안내장',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                        ),
                      ),
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: 'Dismiss',
                          barrierColor: Colors.black54,
                          pageBuilder: (context, anim1, anim2) {
                            return NoticeDialog(notice: _notice);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(15.r),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                      ),
                      child: Text(
                        '설정',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'static',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Setting();
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: Text(
                'EWHA 24 Capstone Project\nin Content Convergence I',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'deco', fontSize: 30.sp, color: Colors.green.shade300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
