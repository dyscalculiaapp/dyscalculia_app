import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'quiz_maker.dart';

QuizMain quizMain = QuizMain();

class Tts extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  Tts() {
    flutterTts.setLanguage("ko-KR");
    flutterTts.setVoice({"name": "ko-kr-x-ism-local", "locale": "ko-KR"});
    flutterTts.setEngine("com.google.android.tts");
    flutterTts.setVolume(0.8);
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            flutterTts.speak(quizMain.answer());
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              //배경색
              foregroundColor: Colors.black,
              //글씨색
              shadowColor: Colors.blue,
              //그림자색
              padding: EdgeInsets.all(30.0),
              //버튼 내 여백
              textStyle: const TextStyle(fontFamily: 'text', fontSize: 20)),
          child: Text(
            '숫자 발음 듣기',
          ),
        ),
      ),
    );
  }
}