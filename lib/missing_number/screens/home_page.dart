import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
                    '눈금 수 찾기',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontFamily: 'text', fontSize: 80.0),
                  ),
                ),
              ),
            ),
            TextButton(
                  style : TextButton.styleFrom(
                    backgroundColor : Colors.green,
                    padding: EdgeInsets.all(20.0),
                  ),
                  child: Text(
                    '시작',
                    style: TextStyle(color: Colors.white, fontFamily: 'text', fontSize: 40.0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SetTotalProblems();
                    }));
                  },
                ),
            Expanded(
              flex: 2,
                child: SizedBox()
            ),
            /*Text(
                'EWHA',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'belgan', fontSize: 100.0, color: Colors.green.shade300),
            ),*/
            Text(
              'EWHA 24 Capstone Project\nin Content Convergence I',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'belgan', fontSize: 45.0, color: Colors.green.shade300),
            ),
            Expanded(
                flex: 2,
                child: SizedBox()
            ),
          ])),
    );
  }
}
