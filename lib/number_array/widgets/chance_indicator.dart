import 'package:flutter/material.dart';

class MYChanceIndicator extends StatelessWidget {
  final int totalChances;
  final int usedChances;
  final double iconSize;
  final Color fillColor;
  final Color emptyColor;

  const MYChanceIndicator({
    Key? key,
    required this.totalChances,
    required this.usedChances,
    this.iconSize = 24.0,
    this.fillColor = Colors.red,
    this.emptyColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = List.generate(totalChances, (index) {
      return Icon(
        Icons.favorite,
        color: index < usedChances ? emptyColor : fillColor,
        size: iconSize,
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons,
    );
  }
}