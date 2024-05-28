import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dyscalculia_app/number_ruler_scales/widgets/progress_indicator.dart';
import 'package:dyscalculia_app/number_ruler_scales/widgets/chance_indicator.dart';
import 'package:dyscalculia_app/number_ruler_scales/widgets/num_pad.dart';
import 'package:dyscalculia_app/number_ruler_scales/widgets/answer_dialog.dart';
import 'package:dyscalculia_app/number_ruler_scales/logic/quiz_maker.dart';
import 'package:dyscalculia_app/number_ruler_scales/screens/finish_page.dart';
import 'package:dyscalculia_app/number_ruler_scales/widgets/ruler.dart';
import 'package:shared_preferences/shared_preferences.dart';

QuizMain quizMain = QuizMain();

class RunQuiz extends StatefulWidget {
  final int totalProblems;

  RunQuiz({Key? key, required this.totalProblems}) : super(key: key);

  @override
  _RunQuizState createState() => _RunQuizState();

}

class _RunQuizState extends State<RunQuiz> {
  var _totalProblem = 0;
  var _chance;
  var _solvedProblem = 0; //푼 문제 개수
  var _correctProblem = 0; //맞힌 문제 개수
  var _score = 0.0; //맞힌 문제에 따른 점수
  var _attempt = 0; // 현재 시도 횟수

  final TextEditingController _myController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _totalProblem = widget.totalProblems;
    _loadChance();
  }

  Future<void> _loadChance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var chance = prefs.getInt('chance') ?? 3;
    setState(() {
      _chance = chance;
    });
  }

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
                contentText: "\n맞았습니다!\n",
                contentTextColor: Colors.cyan.shade500,
                actionText: '결과 보기',
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
                contentText: "\n맞았습니다!\n",
                contentTextColor: Colors.cyan.shade500,
                actionText: '다음 문제',
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
                  contentText: "\n틀렸습니다!\n",
                  contentTextColor: Colors.red.shade400,
                  actionText: '다시 풀기',
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
                  contentText: "\n틀렸습니다!\n",
                  contentTextColor: Colors.red.shade400,
                  actionText: '결과 보기',
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
                    contentText: "\n틀렸습니다!\n",
                    contentTextColor: Colors.red.shade400,
                    actionText: '다음 문제',
                    onActionPressed: () {
                      setState(() => quizMain.next());
                      Navigator.pop(context);
                      _myController.clear();
                      _attempt = 0;
                    },
                    correctAnswerString : quizMain.answer().toString(),
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
        SizedBox(height: 30.0.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h,),
          child :MyProgressIndicator(
            totalProblem: _totalProblem,
            solvedProblem: _solvedProblem,
            minHeight : 40.h,
            color: Colors.green, // 진행 표시기 색상
            backgroundColor: Colors.grey.shade300, // 배경 색상
            valueColor: Colors.green,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: IgnorePointer(
                  child: TextButton(
                    onPressed: () {
                      // 아무 동작도 하지 않음
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      // 배경색
                      foregroundColor: Colors.transparent,
                      // 글씨색
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      // 버튼 내 여백
                      // side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                      // 테두리선
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15.r),
                      // ),
                    ),
                    child: Text(
                      '발음듣기',
                      style: TextStyle(
                        fontFamily: 'static',
                        fontWeight: FontWeight.w700,
                        color: Colors.transparent,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child :MYChanceIndicator(
                  totalChances: _chance,
                  usedChances: _attempt,
                  iconSize: 33.r,
                  fillColor: Colors.red,
                  emptyColor: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: TextButton(
                  onPressed: () {
                    quizMain.next();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return FinishScreen(
                          solevdProblem: _solvedProblem,
                          totalProblem: _totalProblem,
                          score: _score,
                          correctProblem: _correctProblem,
                        );
                      },),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    //배경색
                    foregroundColor: Colors.green,
                    //글씨색
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    //버튼 내 여백
                    //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                    //테두리선
                    //shape: RoundedRectangleBorder(
                    //  borderRadius: BorderRadius.circular(15.r),
                    //),
                  ),
                  child: Text(
                    '종료하기',
                    style: TextStyle(
                      fontFamily: 'static',
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            controller: _myController,
            enableInteractiveSelection: false,
            readOnly: true,
            textAlign: TextAlign.center,
            showCursor: false,

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric( horizontal: 10.w),
            ),

            style: TextStyle(
              fontFamily: 'static',
              fontWeight: FontWeight.w700,
              fontSize: 60.sp,
            ),
            // Disable the default soft keybaord
            keyboardType: TextInputType.none,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            height: 60.h,
            alignment: Alignment.center,
            child: RulerWidget(
              startMark: quizMain.startMark(),
              selectedMark: quizMain.answer(),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: SizedBox(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 55.w),
          child: NumPad(
            buttonSize: 90.r,
            buttonColor: Colors.green,
            iconColor: Colors.blue,
            controller: _myController,
            left: () {
              if (_myController.text.isNotEmpty) {
                _myController.clear();
              }
            },
            right: () {
              if (_myController.text.isNotEmpty) {
                _myController.text = _myController.text.substring(0, _myController.text.length - 1);
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 55.w), // 외부 패딩 지정
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton( //Submit
                  onPressed: () {
                    _check(_myController.text);
                    _myController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    //배경색
                    foregroundColor: Colors.white,
                    //글씨색
                    shadowColor: Colors.black,
                    //그림자색
                    elevation: 5,
                    //그림자 깊이
                    surfaceTintColor : Colors.transparent,

                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    //버튼 내 여백
                    //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                  ),
                  child: Text(
                      '제출하기',
                      style: TextStyle(
                        fontFamily: 'static',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 30.sp,
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