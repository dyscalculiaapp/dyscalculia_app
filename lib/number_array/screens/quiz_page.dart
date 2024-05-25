import 'package:flutter/material.dart';

import 'package:dyscalculia_app/number_array/screens/run_quiz.dart';

class QuizScreen extends StatelessWidget {
  final int totalProblems;

  QuizScreen({Key? key, required this.totalProblems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // 디버그 배너 제거
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RunQuiz(totalProblems: totalProblems),
        ),
      ),
    );
  }
}
