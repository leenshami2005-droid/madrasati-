import 'package:flutter/material.dart';
import 'package:madrasati_plus/const.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, this.onPressed});
  String text;
  VoidCallback? onPressed = () {};

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,

        child: Container(
          width: 300,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: kprimarycolor,
            border: BoxBorder.all(color: Colors.black),
          ),
          child: Text(
            text,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
