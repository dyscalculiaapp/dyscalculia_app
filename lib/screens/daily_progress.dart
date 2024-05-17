import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dyscalculia_app/screens/home_page.dart';
import 'package:dyscalculia_app/widgets/progress_indicator.dart';

class CheckScores extends StatelessWidget {
  Future<int> loadAndUpdateCorrectProblemArrayCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('correctProblemArrayCount_${DateFormat('yyyy-MM-dd').format(DateTime.now())}') ?? 0;  // 기본값으로 0 설정
  }

  Future<int> loadAndUpdateCorrectProblemMissingCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('correctProblemMissingCount_${DateFormat('yyyy-MM-dd').format(DateTime.now())}') ?? 0;  // 기본값으로 0 설정
  }

  Future<int> loadAndUpdateCorrectProblemRulerCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('correctProblemRulerCount_${DateFormat('yyyy-MM-dd').format(DateTime.now())}') ?? 0;  // 기본값으로 0 설정
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // 디버그 배너 제거
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: <Widget>[
            Expanded(flex: 4, child: SizedBox()),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  '달성도 확인',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'text', fontSize: 80.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  '${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'text', fontSize: 20.0),
                ),
              ),
            ),
            Expanded(flex: 8, child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: FutureBuilder<int>(
                future: loadAndUpdateCorrectProblemArrayCount(),
                builder: (context, snapshot) {
                  final arrayCount = snapshot.data ?? 0;
                  return MyProgressIndicator(
                    label: '수 위치 찾기',
                    totalProblem: 20,
                    correctProblem: arrayCount,
                    minHeight: 50.0,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: FutureBuilder<int>(
                future: loadAndUpdateCorrectProblemRulerCount(),
                builder: (context, snapshot) {
                  final arrayCount = snapshot.data ?? 0;
                  return MyProgressIndicator(
                    label: '눈금 수 찾기',
                    totalProblem: 20,
                    correctProblem: arrayCount,
                    minHeight: 50.0,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: FutureBuilder<int>(
                future: loadAndUpdateCorrectProblemMissingCount(),
                builder: (context, snapshot) {
                  final arrayCount = snapshot.data ?? 0;
                  return MyProgressIndicator(
                    label: '사라진 수 찾기',
                    totalProblem: 20,
                    correctProblem: arrayCount,
                    minHeight: 50.0,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                  );
                },
              ),
            ),
            Expanded(flex: 8, child: SizedBox()),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.all(20.0),
              ),
              child: Text(
                '처음으로',
                style: TextStyle(color: Colors.white, fontFamily: 'text', fontSize: 40.0),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return MainScreen();
                    }));
              },
            ),
            Expanded(flex: 5, child: SizedBox()),
          ])),
    );
  }
}
