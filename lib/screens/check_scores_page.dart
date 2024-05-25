import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Future<int> loadGoal(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 20; // 기본값을 20으로 설정
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = List.generate(30, (index) => DateTime.now().subtract(Duration(days: index))); // 지난 30일 날짜 생성

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: Future.wait([
                  loadGoal('goalArray'),
                  loadGoal('goalRuler'),
                  loadGoal('goalMissing'),
                ]),
                builder: (context, AsyncSnapshot<List<int>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  int goalArray = snapshot.data![0];
                  int goalRuler = snapshot.data![1];
                  int goalMissing = snapshot.data![2];

                  return ListView.builder(
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      String date = DateFormat('yyyy-MM-dd').format(dates[index]);
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.r),
                            child: Text(
                              date,
                              style: TextStyle(
                                fontFamily: 'static',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          generateProgressIndicator(context, 'correctProblemArrayCount', date, '수 위치 찾기', Colors.orangeAccent, goalArray),
                          generateProgressIndicator(context, 'correctProblemRulerCount', date, '눈금 수 찾기', Colors.blue, goalRuler),
                          generateProgressIndicator(context, 'correctProblemMissingCount', date, '사라진 수 찾기', Colors.pinkAccent, goalMissing),
                          Divider(thickness: 2),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Divider(height: 0, color: Colors.grey, thickness: 1.0,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.home, size: 30.r),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())),
                  ),
                  IconButton(
                    icon: Icon(Icons.date_range, size: 30.r),
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
    );
  }

  Widget generateProgressIndicator(BuildContext context, String key, String date, String label, Color color, int goal) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: FutureBuilder<int>(
        future: loadScore(key, date),
        builder: (context, snapshot) {
          return MyProgressIndicator(
            label: label,
            totalProblem: goal, // 사용자 목표를 totalProblem으로 설정
            correctProblem: snapshot.data ?? 0,
            minHeight: 40.h,
            color: color,
            backgroundColor: Colors.grey.shade300,
          );
        },
      ),
    );
  }
}
