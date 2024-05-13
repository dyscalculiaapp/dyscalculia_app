import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:dyscalculia_app/number_array/screens/set_total_problem_page.dart';
import 'package:dyscalculia_app/number_ruler_scales/screens/set_total_problem_page.dart';
import 'package:dyscalculia_app/missing_number/screens/set_total_problem_page.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // 디버그 배너 제거
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: <Widget>[
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '수 감각 향상',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontFamily: 'text', fontSize: 80.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              child: Row(
                children: <Widget>[Expanded(
                  flex: 2,
                  child: ElevatedButton(
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
                      //테두리선
                      /*shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                       ),*/
                    ),
                    child: Text(
                      '수 위치 찾기',
                      style: TextStyle(color: Colors.white, fontFamily: 'text', fontSize: 40.0),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return SetTotalProblems_array();
                          })
                      );
                    },
                  ),
                ),],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              child: Row(
                children: <Widget>[Expanded(
                  flex: 2,
                  child: ElevatedButton(
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
                      //테두리선
                      /*shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                       ),*/
                    ),
                    child: Text(
                      '눈금 수 찾기',
                      style: TextStyle(color: Colors.white, fontFamily: 'text', fontSize: 40.0),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return SetTotalProblems_ruler();
                          })
                      );
                    },
                  ),
                ),],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              child: Row(
                children: <Widget>[Expanded(
                  flex: 2,
                  child: ElevatedButton(
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
                      //테두리선
                      /*shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                       ),*/
                    ),
                    child: Text(
                      '사라진 수 찾기',
                      style: TextStyle(color: Colors.white, fontFamily: 'text', fontSize: 40.0),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return SetTotalProblems_missing();
                          })
                      );
                    },
                  ),
                ),],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 50.0),
              child: Row(
                children: <Widget>[Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade300,
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
                      //테두리선
                      /*shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                       ),*/
                    ),
                    child: Text(
                      '달성도 확인',
                      style: TextStyle(color: Colors.white, fontFamily: 'text', fontSize: 40.0),
                    ),
                    onPressed: () {

                    },
                  ),
                ),],
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
              'EWHA 24 Capstone Project\nin Content Convergence I',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'belgan', fontSize: 45.0, color: Colors.green.shade300),
              ),
            ),
          ])),
    );
  }
}
