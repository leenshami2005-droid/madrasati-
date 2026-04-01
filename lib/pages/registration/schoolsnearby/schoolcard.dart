import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Schoolslistcard extends StatelessWidget {
   Schoolslistcard({super.key, required this.schoolname, required this.schoollocation});
  String schoolname ;
  String schoollocation ;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        child: ListTile(
          title:  Text(schoolname),
          subtitle:  Text(schoollocation),
          leading: Image.asset(
            "assets/imgs/image1.png",
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }
}

