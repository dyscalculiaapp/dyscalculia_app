import 'dart:math';

class QuizMain {
  List<int> numList = [0];
  List nameList= ['일', '이', '삼', '사', '오', '육', '칠', '팔', '구', '십',
    '십일', '십이', '십삼', '십사', '십오', '십육', '십칠', '십팔', '십구', '이십',
    '이십일', '이십이', '이십삼', '이십사', '이십오', '이십육', '이십칠', '이십팔', '이십구', '삼십',
    '삼십일', '삼십이', '삼십삼', '삼십사', '삼십오', '삼십육', '삼십칠', '삼십팔', '삼십구', '사십',
    '사십일', '사십이', '사십삼', '사십사', '사십오', '사십육', '사십칠', '사십팔', '사십구', '오십',
    '오십일', '오십이', '오십삼', '오십사', '오십오', '오십육', '오십칠', '오십팔', '오십구', '육십',
    '육십일', '육십이', '육십삼', '육십사', '육십오', '육십육', '육십칠', '육십팔', '육십구', '칠십',
    '칠십일', '칠십이', '칠십삼', '칠십사', '칠십오', '칠십육', '칠십칠', '칠십팔', '칠십구', '팔십',
    '팔십일', '팔십이', '팔십삼', '팔십사', '팔십오', '팔십육', '팔십칠', '팔십팔', '팔십구', '구십',
    '구십일', '구십이', '구십삼', '구십사', '구십오', '구십육', '구십칠', '구십팔', '구십구', '백',
  ];
  List nList= ['은', '은', '는', '은', '는', '는', '은', '은', '은', '는'];

  QuizMain() {
    generateNewQuestion();  // 생성자에서 최초 문제를 생성
  }
  
  void generateNewQuestion() {
    int numItem = new Random().nextInt(100) + 1;

    if (numList.isEmpty) {
      numList.add(numItem);
    } else {
      numList[0] = numItem;
    }
  }

  void next() {
    generateNewQuestion();
  }

  String question() {
    return nameList[numList[0] - 1].toString();
  }

  String question2() {
    return  nList[numList[0] % 10] + ' 어디에 있나요?';
  }

  String answer() {
    var answ = numList[0];
    return answ.toString();
  }
}
