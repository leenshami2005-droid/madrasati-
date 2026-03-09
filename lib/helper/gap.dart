import 'package:flutter/material.dart';

class gap extends StatelessWidget {
  gap({super.key, this.height = 10, this.width = 10});
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
