import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dyscalculia_app/screens/home_page.dart';
import 'package:dyscalculia_app/widgets/progress_indicator.dart';
import 'package:dyscalculia_app/screens/calendar_page.dart';

class CheckScores extends StatelessWidget {
  Future<int> loadScore(String key, String date) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${key}_$date') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = List.generate(30, (index) => DateTime.now().subtract(Duration(days: index))); // 지난 30일 날짜 생성

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea( // SafeArea를 추가하여 상태 바 및 기타 시스템 UI 아래에 내용이 표시되지 않도록 함
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    String date = DateFormat('yyyy-MM-dd').format(dates[index]);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            date,
                            style: TextStyle(fontFamily: 'text', fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        generateProgressIndicator(context, 'correctProblemArrayCount', date, '수 위치 찾기', Colors.green),
                        generateProgressIndicator(context, 'correctProblemRulerCount', date, '눈금 수 찾기', Colors.red),
                        generateProgressIndicator(context, 'correctProblemMissingCount', date, '사라진 수 찾기', Colors.blue),
                        Divider(thickness: 2),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, size: 45),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())),
                    ),
                    IconButton(
                      icon: Icon(Icons.date_range, size: 40),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return TableCalendarScreen();
                            })
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget generateProgressIndicator(BuildContext context, String key, String date, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 8.0),
      child: FutureBuilder<int>(
        future: loadScore(key, date),
        builder: (context, snapshot) {
          return MyProgressIndicator(
            label: label,
            totalProblem: 20,
            correctProblem: snapshot.data ?? 0,
            minHeight: 50.0,
            color: color,
            backgroundColor: Colors.grey.shade300,
          );
        },
      ),
    );
  }
}
