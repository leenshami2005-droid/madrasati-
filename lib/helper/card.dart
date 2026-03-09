import 'package:flutter/material.dart';
import 'package:madrasati_plus/const.dart';

class customCard extends StatelessWidget {
  customCard({super.key, required this.label, required this.name});

  String label;
  String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(50),
      color: kprimarycolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 200, height: 200, child: Image.asset(label)),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }
}
