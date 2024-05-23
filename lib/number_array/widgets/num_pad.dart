import 'package:flutter/material.dart';

class NumPad extends StatefulWidget {
  final double buttonSize;
  final double paddingTB;
  final double paddingElse;
  final Color buttonColor;
  final Color numberColor;
  final TextEditingController controller;

  NumPad({
    Key? key,
    this.buttonSize = 42,
    this.paddingTB = 20,
    this.paddingElse = 10,
    this.buttonColor = Colors.lightGreen,
    this.numberColor = Colors.amber,
    required this.controller,
  }) : super(key: key);

  @override
  NumPadState createState() => NumPadState();
}

class NumPadState extends State<NumPad> {
  void reset() {
    setState(() {
      selectedNumber = null;
    });
  }

  int? selectedNumber; // 현재 선택된 버튼 번호

  void selectNumber(int number) {
    setState(() {
      if (selectedNumber == number) {
        selectedNumber = null; // 같은 버튼을 다시 눌렀을 경우 초기화
        widget.controller.clear();
      } else {
        selectedNumber = number;
        widget.controller.text = number.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    {
      return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(height: widget.paddingTB),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 1; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 11; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 21; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 31; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 41; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 51; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 61; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 71; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 81; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingElse),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // implement the number keys (from 0 to 9) with the NumberButton widget
              // the NumberButton widget is defined in the bottom of this file
              children: List.generate(10, (index) {
                int number = index + 91; // 버튼 번호 계산
                return NumberButton(
                  number: number,
                  size: widget.buttonSize,
                  color: widget.buttonColor,
                  numcolor: widget.numberColor,
                  controller: widget.controller,
                  isSelected: number == selectedNumber, // 선택 상태 전달
                  onSelect: selectNumber, // 콜백 함수 전달
                );
              }),
            ),
            SizedBox(height: widget.paddingTB),
          ],
        ),
      );
    }
  }
}

// NumberButton의 정의를 변경
class NumberButton extends StatefulWidget {
  final int number;
  final double size;
  final Color color;
  final Color numcolor;
  final TextEditingController controller;
  final bool isSelected;
  final Function(int) onSelect;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.numcolor,
    required this.controller,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  _NumberButtonState createState() => _NumberButtonState();
}

class _NumberButtonState extends State<NumberButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: ElevatedButton(
        onPressed: () {
          widget.onSelect(widget.number);
        },
        // 나머지 스타일과 child 설정 유지
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            widget.isSelected ? widget.color : widget.numcolor, // 상태에 따른 색상 결정
          ),

          backgroundColor: MaterialStateProperty.all(
            widget.isSelected ? widget.numcolor : widget.color, // 상태에 따른 색상 결정
          ),

          surfaceTintColor: MaterialStateProperty.all(Colors.transparent),

          side: MaterialStateProperty.all(
            BorderSide(
              color: widget.isSelected ? widget.color : Colors.transparent,
              width: 3.0,
            )
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(0)),

          elevation: MaterialStateProperty.all(2),

          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),)
          ),
          overlayColor: MaterialStateProperty.all(
            widget.isSelected ? widget.numcolor.withOpacity(0.5) : widget.color.withOpacity(0.5),
          ),
        ),
        //side: BorderSide(color: Colors.pink.shade200, width: 3.0,),
        //테두리선
        child: Center(
          child: Text(
            widget.number.toString(),
            style: TextStyle(
              fontFamily: 'static',
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}