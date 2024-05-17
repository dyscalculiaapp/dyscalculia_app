import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dyscalculia_app/screens/home_page.dart';
import 'package:dyscalculia_app/screens/check_scores_page.dart';

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);

  @override
  _TableCalendarScreenState createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _eventMarkers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkerData();
  }

  DateTime _stripTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
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
      if (arrayCount >= 20) dailyMarkers.add('array');

      int rulerCount = prefs.getInt('correctProblemRulerCount_$dateString') ?? 0;
      if (rulerCount >= 20) dailyMarkers.add('ruler');

      int missingCount = prefs.getInt('correctProblemMissingCount_$dateString') ?? 0;
      if (missingCount >= 20) dailyMarkers.add('missing');

      if (dailyMarkers.isNotEmpty) {
        newMarkers[_stripTime(day)] = dailyMarkers;
        print("Markers for $dateString: $dailyMarkers");  // 디버깅용 출력
      }
    }

    setState(() {
      _eventMarkers = newMarkers;
      print("Event Markers Loaded: $_eventMarkers");  // 디버깅용 출력
    });
  }

  List<String> _getEventsForDay(DateTime day) {
    DateTime strippedDay = _stripTime(day);
    List<String> events = _eventMarkers[strippedDay] ?? [];
    print("Events for $strippedDay: $events");  // 디버깅용 출력
    return events;
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
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2024, 01, 01),
                  lastDay: DateTime.utc(2100, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: _getEventsForDay,
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: events.map((event) {
                              Color markerColor;
                              switch (event) {
                                case 'array':
                                  markerColor = Colors.red;
                                  break;
                                case 'ruler':
                                  markerColor = Colors.blue;
                                  break;
                                case 'missing':
                                  markerColor = Colors.green;
                                  break;
                                default:
                                  markerColor = Colors.transparent;
                              }
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(horizontal: 1.5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: markerColor,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  daysOfWeekHeight: 60,
                  rowHeight: 120.0,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextFormatter: (date, locale) => DateFormat.yMMMMd(locale).format(date),
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      fontFamily: 'text',
                      fontSize: 30.0,
                      color: Colors.blue,
                    ),
                    headerPadding: EdgeInsets.symmetric(vertical: 10.0),
                    leftChevronIcon: Icon(Icons.arrow_left, size: 60.0),
                    rightChevronIcon: Icon(Icons.arrow_right, size: 60.0),
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, size: 45),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())),
                    ),
                    IconButton(
                      icon: Icon(Icons.view_headline, size: 40),
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
