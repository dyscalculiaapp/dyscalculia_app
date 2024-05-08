import 'dart:math';

class QuizMain {
  List<int> numList = [0];
  List<int> numListAnswer = [0];

  QuizMain() {
    generateNewQuestion();  // 생성자에서 최초 문제를 생성
  }

  void generateNewQuestion() {
    int startMark = new Random().nextInt(86) + 1;  // 1부터 86까지 랜덤 숫자
    int answer = startMark + new Random().nextInt(15);  // 시작점에 0부터 14까지 더함

    if (numList.isEmpty) {
      numList.add(startMark);
      numListAnswer.add(answer);
    } else {
      numList[0] = startMark;
      numListAnswer[0] = answer;
    }
  }

  void next() {
    generateNewQuestion();  // 다음 문제 생성
  }

  int startMark() {
    return numList.isNotEmpty ? numList[0] : 1;  // 리스트가 비어있지 않으면 현재 시작점 반환
  }

  int answer() {
    return numListAnswer.isNotEmpty ? numListAnswer[0] : 0;  // 리스트가 비어있지 않으면 현재 정답 반환
  }
}