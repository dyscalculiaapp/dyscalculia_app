import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:dyscalculia_app/screens/home_page.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen(
      {super.key,
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
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double percentageScore = score;
    int roundedPercentageScore = percentageScore.round();

    if (roundedPercentageScore < 0){
      roundedPercentageScore = 0;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,  // 디버그 배너 제거
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: <Widget>[
            Expanded(
              flex: 5,
              child: SizedBox(),
            ),
            Column (children:[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '결과',
                    textAlign: TextAlign.center,
                    style:
                      TextStyle(fontFamily: 'text', fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '$totalProblem 문제 중에 \n$correctProblem 문제 맞혔습니다!\n\n'
                        '100점 만점에',
                    textAlign: TextAlign.center,
                    style:
                      TextStyle(fontFamily: 'text', fontSize: 40.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '$roundedPercentageScore점',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontFamily: 'text', fontSize: 80.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: roundedPercentageScore >= 80
                  ? Text(
                  '잘했습니다!',
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(color: Colors.cyan.shade500, fontFamily: 'text', fontSize: 40.0),
                  )
                  : Text(
                  '조금 더 노력하세요!',
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(color: Colors.red.shade400, fontFamily: 'text', fontSize: 40.0),
                  ),
              ),
              ]),
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            TextButton(
                  style : TextButton.styleFrom(
                    backgroundColor : Colors.green,
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
            Expanded(
              flex: 5,
              child: SizedBox(),
            )
          ])),
    );
  }
}
