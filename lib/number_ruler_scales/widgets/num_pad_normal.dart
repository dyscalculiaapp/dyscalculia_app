import 'package:flutter/material.dart';
import 'package:dyscalculia_app/number_ruler_scales/screens/quiz_page.dart';
// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPadNormal extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function left;
  final Function right;

  const NumPadNormal({
    Key? key,
    this.buttonSize = 70,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    required this.left,
    required this.right,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: [
              NumberButton(
                number: 1,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 2,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 3,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumberButton(
                number: 4,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 5,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 6,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumberButton(
                number: 7,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 8,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 9,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // this button is used to delete the last number
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: iconColor,
                    foregroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    controller.text = left.toString();
                  },
                  child: Center(
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: 50,
                    ),
                  ),
                ),
              ),
              NumberButton(
                number: 0,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              // this button is used to submit the entered value
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: iconColor,
                    foregroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    right();
                  },
                  child: Center(
                    child: Icon(
                      Icons.backspace_outlined,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                      '시작',
                      style: TextStyle(
                        fontFamily: 'static',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: iconColor,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 5,
                      surfaceTintColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      int totalProblems = int.tryParse(controller.text) ?? 10;
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
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: color,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontFamily: 'static',
                fontWeight: FontWeight.w700, color: Colors.white, fontSize: 50),
          ),
        ),
      ),
    );
  }
}