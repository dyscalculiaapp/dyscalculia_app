import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dyscalculia_app/screens/home_page.dart';
import 'package:dyscalculia_app/screens/check_scores_page.dart';
import 'package:dyscalculia_app/widgets/progress_indicator.dart';

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);

  @override
  _TableCalendarScreenState createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _eventMarkers = {};
  int goalArray = 20;
  int goalRuler = 20;
  int goalMissing = 20;

  @override
  void initState() {
    super.initState();
    _loadGoals();
    _loadMarkerData();
  }

  DateTime _stripTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      goalArray = prefs.getInt('goalArray') ?? 20;
      goalRuler = prefs.getInt('goalRuler') ?? 20;
      goalMissing = prefs.getInt('goalMissing') ?? 20;
    });
  }

  Future<void> _loadMarkerData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<DateTime, List<String>> newMarkers = {};
    DateTime startDate = DateTime.now().subtract(Duration(days: 30));
    DateTime endDate = DateTime.now().add(Duration(days: 30));

    for (DateTime day = startDate; day.isBefore(endDate); day = day.add(Duration(days: 1))) {
      List<String> dailyMarkers = [];
      String dateString = DateFormat('yyyy-MM-dd').format(day.toLocal());

      int arrayCount = prefs.getInt('correctProblemArrayCount_$dateString') ?? 0;
      if (arrayCount >= goalArray) dailyMarkers.add('array');

      int rulerCount = prefs.getInt('correctProblemRulerCount_$dateString') ?? 0;
      if (rulerCount >= goalRuler) dailyMarkers.add('ruler');

      int missingCount = prefs.getInt('correctProblemMissingCount_$dateString') ?? 0;
      if (missingCount >= goalMissing) dailyMarkers.add('missing');

      if (dailyMarkers.isNotEmpty) {
        newMarkers[_stripTime(day)] = dailyMarkers;
      }
    }

    setState(() {
      _eventMarkers = newMarkers;
    });
  }

  List<String> _getEventsForDay(DateTime day) {
    DateTime strippedDay = _stripTime(day);
    List<String> events = _eventMarkers[strippedDay] ?? [];
    return events;
  }

  Color _getTextColor(DateTime day) {
    if (day.weekday == DateTime.saturday) {
      return Colors.blue;
    } else if (day.weekday == DateTime.sunday) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  Color _getTextColorOut(DateTime day) {
    if (day.weekday == DateTime.saturday) {
      return Colors.blue.shade200;
    } else if (day.weekday == DateTime.sunday) {
      return Colors.red.shade200;
    } else {
      return Colors.grey;
    }
  }

  Color _getDowTextColor(String weekday) {
    if (weekday == '토') {
      return Colors.blue;
    } else if (weekday == '일') {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  Future<void> _showDayDetailsDialog(DateTime day) async {
    String dateString = DateFormat('yyyy-MM-dd').format(day);
    int arrayCount = await _loadScore('correctProblemArrayCount', dateString);
    int rulerCount = await _loadScore('correctProblemRulerCount', dateString);
    int missingCount = await _loadScore('correctProblemMissingCount', dateString);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.white60, // 다이얼로그 외부 틴트 컬러
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: StatefulBuilder(
            builder: (context, setState) {
              Future<void> _updateDayDetails(DateTime newDay) async {
                setState(() {
                  day = newDay;
                });
                dateString = DateFormat('yyyy-MM-dd').format(newDay);
                arrayCount = await _loadScore('correctProblemArrayCount', dateString);
                rulerCount = await _loadScore('correctProblemRulerCount', dateString);
                missingCount = await _loadScore('correctProblemMissingCount', dateString);
              }

              return GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    // 스와이프 오른쪽 -> 이전 날짜
                    _updateDayDetails(day.subtract(Duration(days: 1)));
                  } else if (details.primaryVelocity! < 0) {
                    // 스와이프 왼쪽 -> 다음 날짜
                    _updateDayDetails(day.add(Duration(days: 1)));
                  }
                },
                child: Dialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  elevation: 10.0,
                  shadowColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                    side: BorderSide(color: Colors.green, width: 2.0), // 다이얼로그 테두리 색
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0), // 다이얼로그 패딩 추가
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              '$dateString',
                              style: TextStyle(
                                fontFamily: 'static',
                                fontSize: 30.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Divider(height: 0, color: Colors.green, thickness: 2.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: Column(
                              children: [
                                _generateProgressIndicator(context, '수 위치 찾기', arrayCount, Colors.green, goalArray),
                                _generateProgressIndicator(context, '눈금 수 찾기', rulerCount, Colors.red, goalRuler),
                                _generateProgressIndicator(context, '사라진 수 찾기', missingCount, Colors.blue, goalMissing),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_left_outlined,
                                    color: Colors.green,
                                    size: 80,
                                  ),
                                  onPressed: () => _updateDayDetails(day.subtract(Duration(days: 1))),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                      fontFamily: 'static',
                                      fontSize: 30.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_right_outlined,
                                    color: Colors.green,
                                    size: 80,
                                  ),
                                  onPressed: () => _updateDayDetails(day.add(Duration(days: 1))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<int> _loadScore(String key, String date) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${key}_$date') ?? 0;
  }

  Future<int> loadGoal(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 20;
  }

  Widget _generateProgressIndicator(BuildContext context, String label, int correctProblem, Color color, int goal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MyProgressIndicator(
        label: label,
        totalProblem: goal,
        correctProblem: correctProblem,
        minHeight: 60.0,
        color: color,
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              Expanded(
                child: FutureBuilder<List<int>>(
                  future: Future.wait([
                    loadGoal('goalArray'),
                    loadGoal('goalRuler'),
                    loadGoal('goalMissing'),
                  ]),
                  builder: (context, AsyncSnapshot<List<int>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    goalArray = snapshot.data![0];
                    goalRuler = snapshot.data![1];
                    goalMissing = snapshot.data![2];

                    return TableCalendar(
                      locale: 'ko_KR',
                      firstDay: DateTime.utc(2024, 01, 01),
                      lastDay: DateTime.utc(2100, 3, 14),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _showDayDetailsDialog(selectedDay);  // 날짜 선택 시 다이얼로그 표시
                        });
                      },
                      eventLoader: _getEventsForDay,
                      daysOfWeekHeight: 40,
                      rowHeight: 150.0,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        titleTextFormatter: (date, locale) => DateFormat.yMMMM(locale).format(date),
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          fontFamily: 'static',
                          fontSize: 30.0,
                          color: Colors.green,
                        ),
                        headerPadding: EdgeInsets.symmetric(vertical: 10.0),
                        leftChevronIcon: Icon(Icons.arrow_left, size: 40.0),
                        rightChevronIcon: Icon(Icons.arrow_right, size: 40.0),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        weekendStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                        ),
                        dowTextFormatter: (date, locale) {
                          String weekday = DateFormat.E(locale).format(date);
                          return weekday;
                        },
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(
                          color: Colors.black,
                        ),
                        weekendTextStyle: TextStyle(
                          color: Colors.red,
                        ),
                        outsideTextStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2.0), // 테두리만 있는 원
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        tableBorder: const TableBorder(
                          top: BorderSide(
                              color: Colors.grey
                          ),
                          bottom: BorderSide(
                              color: Colors.grey
                          ),
                          // calendar 의 내부 가로선
                          horizontalInside: BorderSide(
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  '${day.day}',  // 숫자만 표시
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: _getTextColor(day),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        outsideBuilder: (context, day, focusedDay) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  '${day.day}',  // 숫자만 표시
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: _getTextColorOut(day),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        selectedBuilder: (context, day, focusedDay) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.green, width: 2.0), // 테두리만 있는 원
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      '${day.day}',  // 숫자만 표시
                                      style: TextStyle(
                                        color: _getTextColor(day),
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        todayBuilder: (context, day, focusedDay) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      '${day.day}',  // 숫자만 표시
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        markerBuilder: (context, day, events) {
                          if (events.isNotEmpty) {
                            return Positioned(
                              bottom: 10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: events.map((event) {
                                  Color markerColor;
                                  switch (event) {
                                    case 'array':
                                      markerColor = Colors.orangeAccent;
                                      break;
                                    case 'ruler':
                                      markerColor = Colors.blue;
                                      break;
                                    case 'missing':
                                      markerColor = Colors.pinkAccent;
                                      break;
                                    default:
                                      markerColor = Colors.transparent;
                                  }
                                  return Container(
                                    width: 40.0,
                                    height: 10.0,
                                    margin: EdgeInsets.symmetric(vertical: 2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: markerColor,
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                          return null;
                        },
                        dowBuilder: (context, day) {
                          final text = DateFormat.E('ko_KR').format(day);
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: _getDowTextColor(text),
                                fontSize: 20.0,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 0, color: Colors.grey, thickness: 2.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, size: 45),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())),
                    ),
                    IconButton(
                      icon: Icon(Icons.view_headline, size: 45),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CheckScores()));
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
}
