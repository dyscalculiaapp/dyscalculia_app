import 'package:flutter/material.dart';
import 'package:dyscalculia_app/number_missing/screens/quiz_page.dart';
import 'package:dyscalculia_app/number_missing/widgets/num_pad_normal.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: SetTotalProblems_missing(),
    );
  }
}

class SetTotalProblems_missing extends StatefulWidget {
  @override
  _SetTotalProblemsState createState() => _SetTotalProblemsState();
}

class _SetTotalProblemsState extends State<SetTotalProblems_missing> {
  final TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                '풀 문제 수를\n입력해주세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'static',
                  fontSize: 50.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 0.0),
              child: TextField(
                controller: _myController,
                readOnly: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 5.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 5.0,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'static',
                  fontSize: 80.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            NumPadNormal(
              buttonSize: 100,
              fontSizeL: 50,
              fontSizeR: 30,
              buttonColor: Colors.green,
              iconColor: Colors.cyan.shade500,
              controller: _myController,
              left: () {
                if (_myController.text.isNotEmpty) {
                  _myController.text = _myController.text.substring(0, _myController.text.length - 1);
                }
              },
              right: () {
                _myController.text = 10.toString();
              },
              buttonText: '추천',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        '시작',
                        style: TextStyle(
                          fontFamily: 'static',
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        surfaceTintColor: Colors.transparent,
                        padding: EdgeInsets.all(20.0),
                      ),
                      onPressed: () {
                        int totalProblems = int.tryParse(_myController.text) ?? 10;
                        if (totalProblems == 0) {
                          totalProblems = 10;
                        }
                        if (totalProblems > 50) {
                          totalProblems = 50;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => QuizScreen(totalProblems: totalProblems)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text(
                '아무 것도 입력하지 않거나 0을 입력한다면\n추천 설정으로 시작합니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'static',
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
