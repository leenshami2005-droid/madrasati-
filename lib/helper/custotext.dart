import 'package:flutter/material.dart';

class customtext extends StatelessWidget {
  customtext({
    super.key,
    required this.text,
    this.size = 20,
    this.color = Colors.black,
  });
  String text;
  double size;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontFamily: "font1",
        fontSize: size,
      ),
    );
  }
}
