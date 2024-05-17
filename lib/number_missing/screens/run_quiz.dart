import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dyscalculia_app/number_missing/widgets/progress_indicator.dart';
import 'package:dyscalculia_app/number_missing/widgets/chance_indicator.dart';
import 'package:dyscalculia_app/number_missing/widgets/num_pad_normal.dart';
import 'package:dyscalculia_app/number_missing/widgets/answer_dialog.dart';
import 'package:dyscalculia_app/number_missing/logic/quiz_maker.dart';
import 'package:dyscalculia_app/number_missing/screens/finish_page.dart';

QuizMain quizMain = QuizMain();

class RunQuiz extends StatefulWidget {
  final int totalProblems;

  RunQuiz({Key? key, required this.totalProblems}) : super(key: key);

  @override
  _RunQuizState createState() => _RunQuizState();

}

class _RunQuizState extends State<RunQuiz> {
  var _totalProblem = 0;
  final TextEditingController _myController = TextEditingController();
  int wrongCount = 0;
  int lastGameWrongCount = 0;


  @override
  void initState() {
    super.initState();
    _totalProblem = widget.totalProblems;
    loadWrongCount();
  }

  Future<void> loadWrongCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastGameWrongCount = prefs.getInt('wrongCount') ?? 0;
      wrongCount = 0; // Reset wrong count for a new game
    });
  }

  Future<void> saveWrongCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('wrongCount', wrongCount);
  }

  //총 문제 개수
  var _solvedProblem = 0; //푼 문제 개수
  var _correctProblem = 0; //맞힌 문제 개수
  var _score = 0.0; //맞힌 문제에 따른 점수
  var _attempt = 0; // 현재 시도 횟수
  var _chance = 3;

  void _check(var Answer) {
    var correctAnswer = quizMain.answer();
    var userAnswer = int.parse(Answer);

    setState(() {

      if (correctAnswer == userAnswer) {
        if (_solvedProblem + 1 == _totalProblem){
          _score += 100 / _totalProblem * (_chance - _attempt) / _chance;
          _correctProblem += 1;
          _solvedProblem += 1;
          showDialog( // 맞았을 때 다이얼로그
            context: context,
            barrierColor: Colors.green,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return MYAnswerDialog(
                backgroundColor: Colors.white,
                borderRadius: 50.0,
                shadowColor: Colors.blue,
                contentText: "맞았습니다!\n",
                font: 'text',
                underlineGap: -15,
                contentTextColor: Colors.cyan.shade500,
                contentFontSize: 60.0,
                underlineColor: Colors.cyan.shade500,
                underlineThickness: 5.0,
                actionText: '결과 보기',
                actionButtonColor: Colors.green,
                actionTextColor: Colors.white,
                actionTextSize: 40.0,
                correctAnswerString : quizMain.answer().toString(),
                onActionPressed: () {
                  setState(() => quizMain.next());
                  Navigator.of(context).pop();
                  //_numPadKey.currentState?.reset();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return FinishScreen(
                              solevdProblem: _solvedProblem,
                              totalProblem: _totalProblem,
                              score: _score,
                              correctProblem: _correctProblem,
                            );
                          }
                      )
                  );
                  _myController.clear();
                  _attempt = 0;
                },
              );
            },
          );

        } else {
          _correctProblem += 1;
          _score += 100 / _totalProblem * (_chance - _attempt) / _chance;
          _solvedProblem += 1;
          // 필요한 부분에 다음 코드를 삽입합니다.
          showDialog( // 맞았을 때 다이얼로그
            context: context,
            barrierColor: Colors.green,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return MYAnswerDialog(
                backgroundColor: Colors.white,
                borderRadius: 50.0,
                shadowColor: Colors.blue,
                contentText: "맞았습니다!\n",
                font: 'text',
                underlineGap: -15,
                contentTextColor: Colors.cyan.shade500,
                contentFontSize: 60.0,
                underlineColor: Colors.cyan.shade500,
                underlineThickness: 5.0,
                actionText: '다음 문제',
                actionButtonColor: Colors.green,
                actionTextColor: Colors.white,
                actionTextSize: 40.0,
                onActionPressed: () {
                  setState(() => quizMain.next());
                  Navigator.of(context).pop();
                  _myController.clear();
                  _attempt = 0;
                },
                correctAnswerString : quizMain.answer().toString(),
              );
            },
          );
        }
      } else { //틀렸을 때
        if (_attempt < _chance - 1) {
          _attempt += 1;
          showDialog( //틀렸는데 기회가 남아있어 다시 풀 수 있을 때 다이얼로그
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.green,
              builder: (BuildContext context) {
                return MYAnswerDialog(
                  backgroundColor: Colors.white,
                  borderRadius: 50.0,
                  shadowColor: Colors.blue,
                  contentText: "\n틀렸습니다!\n",
                  font: 'text',
                  underlineGap: -15,
                  contentTextColor: Colors.red.shade400,
                  contentFontSize: 60.0,
                  underlineColor: Colors.red.shade400,
                  underlineThickness: 5.0,
                  actionText: '다시 풀기',
                  actionButtonColor: Colors.green,
                  actionTextColor: Colors.white,
                  actionTextSize: 40.0,
                  onActionPressed: () {
                    Navigator.pop(context);
                    _myController.clear();
                  },
                  correctAnswerString : quizMain.answer().toString(),
                );
              }
          );
        } else if (_attempt ==_chance - 1){
          if (_solvedProblem + 1 == _totalProblem) {
            _solvedProblem += 1;
            showDialog( // 맞았을 때 다이얼로그
              context: context,
              barrierColor: Colors.green,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return MYAnswerDialog(
                  backgroundColor: Colors.white,
                  borderRadius: 50.0,
                  shadowColor: Colors.blue,
                  contentText: "틀렸습니다!\n",
                  font: 'text',
                  underlineGap: -15,
                  contentTextColor: Colors.red.shade400,
                  contentFontSize: 60.0,
                  underlineColor: Colors.red.shade400,
                  underlineThickness: 5.0,
                  actionText: '결과 보기',
                  actionButtonColor: Colors.green,
                  actionTextColor: Colors.white,
                  actionTextSize: 40.0,
                  correctAnswerString : quizMain.answer().toString(),
                  onActionPressed: () {
                    setState(() => quizMain.next());
                    Navigator.of(context).pop();
                    //_numPadKey.currentState?.reset();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return FinishScreen(
                                solevdProblem: _solvedProblem,
                                totalProblem: _totalProblem,
                                score: _score,
                                correctProblem: _correctProblem,
                              );
                            }
                        )
                    );
                    _myController.clear();
                    _attempt = 0;
                  },
                );
              },
            );
          } else {
            _solvedProblem += 1;
            showDialog( //틀렸는데 기회가 남지 않아 다음 문제로 넘어가야 할 때 다이얼로그
                context: context,
                barrierDismissible: false,
                barrierColor: Colors.green,
                builder: (BuildContext context) {
                  return MYAnswerDialog(
                    backgroundColor: Colors.white,
                    borderRadius: 50.0,
                    shadowColor: Colors.blue,
                    contentText: "틀렸습니다!\n",
                    font: 'text',
                    underlineGap: -15,
                    contentTextColor: Colors.red.shade400,
                    contentFontSize: 60.0,
                    underlineColor: Colors.red.shade400,
                    underlineThickness: 5.0,
                    actionText: '다음 문제',
                    actionButtonColor: Colors.green,
                    actionTextColor: Colors.white,
                    actionTextSize: 40.0,
                    onActionPressed: () {
                      setState(() => quizMain.next());
                      Navigator.pop(context);
                      _myController.clear();
                      _attempt = 0;
                    },
                    correctAnswerString : quizMain.startMark().toString(),
                  );
                }
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child :MyProgressIndicator(
            totalProblem: _totalProblem,
            solvedProblem: _solvedProblem,
            minHeight : 50.0,
            color: Colors.green, // 진행 표시기 색상
            backgroundColor: Colors.grey.shade300, // 배경 색상
            valueColor: Colors.green,
          )
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(00.0, 00.0, 0.0, 0.0),
                child: TextButton(
                  onPressed: () {
                    //flutterTts.speak(quizMain.question());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    //배경색
                    foregroundColor: Colors.green,
                    //글씨색
                    shadowColor: Colors.blue,
                    //그림자색
                    padding: EdgeInsets.all(10.0),
                    //버튼 내 여백
                    //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                    //테두리선
                    //shape: RoundedRectangleBorder(
                    //  borderRadius: BorderRadius.circular(20),
                    //),
                  ),
                  child: Text(
                      '발음듣기',
                      style: TextStyle(
                        fontFamily: 'text',
                        color: Colors.transparent,
                        fontSize: 30.0,
                      )
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(0),
                  child :MYChanceIndicator(
                    totalChances: _chance,
                    usedChances: _attempt,
                    iconSize: 40.0,
                    fillColor: Colors.red,
                    emptyColor: Colors.grey,
                  )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(00.0, 00.0, 0.0, 0.0),
                child: TextButton(
                  onPressed: () /*{
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }));
                  },*/
                  {quizMain.next();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return FinishScreen(
                                solevdProblem: _solvedProblem,
                                totalProblem: _totalProblem,
                                score: _score,
                                correctProblem: _correctProblem,
                              );
                            }
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    //배경색
                    foregroundColor: Colors.green,
                    //글씨색
                    shadowColor: Colors.blue,
                    //그림자색
                    padding: EdgeInsets.all(10.0),
                    //버튼 내 여백
                    //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                    //테두리선
                    //shape: RoundedRectangleBorder(
                    //  borderRadius: BorderRadius.circular(20),
                    //),
                  ),
                  child: Text(
                      '종료하기',
                      style: TextStyle(
                        fontFamily: 'text',
                        color: Colors.green,
                        fontSize: 30.0,
                      )
                  ),
                ),
              ),
            ]),
        Expanded(
          flex: 3,
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // 전체 그리드에 적용될 패딩
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // 한 줄에 5개의 그리드
              childAspectRatio: 1, // 그리드의 종횡비 1:1
            ),
            itemCount: 10, // 총 10개 아이템
            itemBuilder: (context, index) {
              bool isSpecial = quizMain.index() == index; // 특별 처리가 필요한 조건
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSpecial ? Colors.green : Colors.white, // 조건에 따른 배경색 변경
                  border: Border.all(color: Colors.green, width: 3.0), // 테두리
                ),
                child: isSpecial ?
                TextField(
                  controller: _myController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  showCursor: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green,
                    border: InputBorder.none,
                    hintText: '?',
                    hintStyle: TextStyle(fontFamily: 'text', fontSize: 30, color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: 'text', fontSize: 30, color: Colors.white),
                ) :
                Text(quizMain.numbers()[index].toString(), style: TextStyle(fontFamily: 'text', fontSize: 30)),
              );
            },
            shrinkWrap: true, // 그리드 뷰가 차지하는 공간을 내용물에 맞춤
            physics: NeverScrollableScrollPhysics(), // 스크롤 불가능 // 스크롤 불가능
          ),
        ),
        Expanded(
          flex: 4,
          child: SizedBox(),
        ),
        NumPadNormal(
          buttonSize: 100,
          fontSizeL: 50,
          fontSizeR: 70,
          buttonColor: Colors.green,
          iconColor: Colors.red.shade500,
          controller: _myController,
          left: () {
            if (_myController.text.isNotEmpty) {
              _myController.text = _myController.text.substring(0, _myController.text.length - 1);
            }
          },
          right: () {
            if (_myController.text.isNotEmpty) {
              _myController.clear();
            }
          },
          buttonText: '×',
        ),
        Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.0), // 외부 패딩 지정
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton( //Submit
                  onPressed: () {
                    _check(_myController.text);
                    //_myController.clear();
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    //배경색
                    foregroundColor: Colors.white,
                    //글씨색
                    shadowColor: Colors.black,
                    //그림자색
                    elevation: 5,
                    //그림자 깊이
                    surfaceTintColor : Colors.transparent,

                    padding: EdgeInsets.all(20.0),
                    //버튼 내 여백
                    //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                    //테두리선
                    /*shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    ),*/
                  ),
                  child: Text(
                      '답 확인하기',
                      style: TextStyle(
                        fontFamily: 'text',
                        color: Colors.white,
                        fontSize: 40,
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: SizedBox(),
        )
      ],
    );
  }
}