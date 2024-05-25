import 'package:flutter/material.dart';
import 'package:dyscalculia_app/number_ruler_scales/widgets/num_pad_normal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: SetTotalProblems_ruler(),
    );
  }
}

class SetTotalProblems_ruler extends StatefulWidget {
  @override
  _SetTotalProblemsState createState() => _SetTotalProblemsState();
}

class _SetTotalProblemsState extends State<SetTotalProblems_ruler> {
  final TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                '풀 문제 수를 입력하세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'static',
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                '입력하지 않거나 0을 입력한다면\n추천 설정으로 시작합니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'static',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextField(
                controller: _myController,
                readOnly: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric( horizontal: 10.w),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 5.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 5.w,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'static',
                  fontWeight: FontWeight.w900,
                  fontSize: 70.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: NumPadNormal(
                buttonSize: 90.r,
                buttonColor: Colors.green,
                iconColor: Colors.blue,
                controller: _myController,
                left: () {
                  _myController.text = 10.toString();
                },
                right: () {
                  if (_myController.text.isNotEmpty) {
                    _myController.text = _myController.text.substring(0, _myController.text.length - 1);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
