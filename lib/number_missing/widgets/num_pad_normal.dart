import 'package:flutter/material.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPadNormal extends StatelessWidget {
  final double buttonSize;
  final double fontSizeL;
  final double fontSizeR;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function left;
  final Function right;
  final String buttonText;

  const NumPadNormal({
    Key? key,
    this.buttonSize = 70,
    this.fontSizeL = 70,
    this.fontSizeR = 70,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    required this.left,
    required this.right,
    required this.controller,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // this button is used to delete the last number
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: iconColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonSize / 2),
                    ),
                  ),
                  onPressed: () {
                    left();
                  },
                  child: Center(
                    child: Text(
                      '<',
                      style: TextStyle(
                          fontFamily: 'text',
                          fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeL),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonSize / 2),
                    ),
                  ),
                  onPressed: () {
                    right();
                  },
                  child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                          fontFamily: 'text',
                          fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeR),
                    ),
                  ),
                ),
              ),
            ],
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontFamily: 'text',
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
          ),
        ),
      ),
    );
  }
}