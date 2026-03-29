import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/gap.dart';

class absencecard extends StatelessWidget {
   absencecard({super.key , required this.text, required this.number});
  String text;
  int number;

  @override
  Widget build(BuildContext context) {
    return  Card(child: Container(padding: EdgeInsets.all(10),child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text(text, textAlign: TextAlign.right,style: TextStyle(color: Color(0xffC1C1C1),fontSize: 12),),
                           gap(height: 10,),
                           Text("${number}",style: TextStyle(fontWeight: FontWeight.w700 ,color: Color(0xff2A3F6F),fontSize: 22),)
                           
                         ],
                       )))
 ;
  }
}