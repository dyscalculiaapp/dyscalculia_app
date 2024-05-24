import 'package:flutter/material.dart';
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
    DateTime now = DateTime.now().toLocal();
    String todayKey = 'correctProblemArrayCount_${DateFormat('yyyy-MM-dd').format(now)}'; // 현재 날짜를 yyyy-MM-dd 형식으로 변환
    correctProblemArrayCount = prefs.getInt(todayKey) ?? 0;
    correctProblemArrayCount += widget.correctProblem;

    await prefs.setInt(todayKey, correctProblemArrayCount);
    print("Data saved for $todayKey: $correctProblemArrayCount");
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Dialog(
                backgroundColor: Colors.green,
                surfaceTintColor: Colors.transparent,
                elevation: 10.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(color: Colors.green, width: 2.0), // 다이얼로그 테두리 색
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0), // 다이얼로그 패딩 추가
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '결과',
                            style: TextStyle(
                              fontFamily: 'static',
                              fontWeight: FontWeight.w700,
                              fontSize: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Divider(height: 0, color: Colors.white, thickness: 2.0,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 00.0),
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              '$roundedPercentageScore점',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'static',
                                                fontSize: 100.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Text(
                                              '$roundedPercentageScore점',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.transparent,
                                                fontFamily: 'text',
                                                fontSize: 100.0,
                                                decoration: TextDecoration.underline,
                                                decorationColor: Colors.green,
                                                decorationStyle: TextDecorationStyle.wavy,
                                                decorationThickness: 5.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0,),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20.0), // 텍스트와 상자 사이의 여백
                                        decoration: BoxDecoration(
                                          color: Colors.transparent, // 배경 색상 지정
                                          borderRadius: BorderRadius.circular(15.0), // 모서리 둥글게
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.transparent,
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // 그림자의 위치
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          '${widget.totalProblem} 문제 중에 \n${widget.correctProblem} 문제 맞혔습니다!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'static',
                                            fontSize: 40.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(30.0), // 텍스트와 상자 사이의 여백
                                        decoration: BoxDecoration(
                                          color: Colors.transparent, // 배경 색상 지정
                                          borderRadius: BorderRadius.circular(15.0), // 모서리 둥글게
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.transparent,
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // 그림자의 위치
                                            ),
                                          ],
                                        ),
                                        child: roundedPercentageScore >= 80
                                            ? Text(
                                          '잘했습니다!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.cyan.shade500,
                                            fontFamily: 'static',
                                            fontSize: 40.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                            : Text(
                                          '노력하세요!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontFamily: 'static',
                                            fontSize: 40.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(),
                        ),
                        Divider(height: 0, color: Colors.white, thickness: 2.0,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    surfaceTintColor: Colors.transparent,
                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: Text(
                                    '처음으로',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'static',
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                                  },
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
            ]
        ),
      ),
    );
  }
}
