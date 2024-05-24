import 'dart:math';

class QuizMain {
  List<int> numList = [0];
  List<int> numListIndex = [0];

  QuizMain() {
    generateNewQuestion();  // 생성자에서 최초 문제를 생성
  }

  void generateNewQuestion() {
    int startMark = new Random().nextInt(91) + 1;  // 1 11 21 31 41 51 61 71 81중에 랜덤 숫자
    int index = new Random().nextInt(10);

    if (numList.isEmpty) {
      numList.add(startMark);
      numListIndex.add(index);
    } else {
      numList[0] = startMark;
      numListIndex[0] = index;
    }
  }



  void next() {
    generateNewQuestion();  // 다음 문제 생성
  }

  int startMark() {
    return numList.isNotEmpty ? numList[0] : 1;  // 리스트가 비어있지 않으면 현재 시작점 반환
  }

  int index() {
    return numListIndex.isNotEmpty ? numListIndex[0] : 0;  // 리스트가 비어있지 않으면 현재 정답 반환
  }

  int answer() {
    return numList[0] + numListIndex[0];  // 리스트가 비어있지 않으면 현재 정답 반환
  }

  List numbers() {
    return List.generate(10, (index) => index + numList[0]);  // 리스트가 비어있지 않으면 현재 정답 반환
  }
}