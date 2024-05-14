import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dyscalculia_app/screens/home_page.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({
    super.key,
    required this.solevdProblem,
    required this.correctProblem,
    required this.totalProblem,
    required this.score,
  });

  final int solevdProblem;
  final int correctProblem;
  final int totalProblem;
  final double score;

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  int correctProblemArrayCount = 0;

  @override
  void initState() {
    super.initState();
    loadAndUpdateCorrectProblemArrayCount();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  Future<void> loadAndUpdateCorrectProblemArrayCount() async {
    final prefs = await SharedPreferences.getInstance();
    String todayKey = 'correctProblemArrayCount_${DateFormat('yyyy-MM-dd').format(DateTime.now())}'; // 현재 날짜를 yyyy-MM-dd 형식으로 변환
    correctProblemArrayCount = prefs.getInt('correctProblemArrayCount_${DateFormat('yyyy-MM-dd').format(DateTime.now())}') ?? 0;
    correctProblemArrayCount += widget.correctProblem;

    await prefs.setInt(todayKey, correctProblemArrayCount);
  }

  @override
  Widget build(BuildContext context) {
    double percentageScore = widget.score;
    int roundedPercentageScore = percentageScore.round();
    if (roundedPercentageScore < 0) {
      roundedPercentageScore = 0;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: SizedBox(),
              ),
              Column(children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      '결과',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'text', fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      '${widget.totalProblem} 문제 중에 \n${widget.correctProblem} 문제 맞혔습니다!\n\n100점 만점에',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'text', fontSize: 40.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      '$roundedPercentageScore점',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'text', fontSize: 80.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: roundedPercentageScore >= 80
                      ? Text(
                    '잘했습니다!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.cyan.shade500, fontFamily: 'text', fontSize: 40.0),
                  )
                      : Text(
                    '조금 더 노력하세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red.shade400, fontFamily: 'text', fontSize: 40.0),
                  ),
                ),
              ]),
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                },
              ),
              Expanded(
                flex: 5,
                child: SizedBox(),
              )
            ]
        ),
      ),
    );
  }
}
