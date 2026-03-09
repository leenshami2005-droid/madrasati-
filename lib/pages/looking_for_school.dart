import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/custombutton.dart';
import 'package:madrasati_plus/helper/custotext.dart';
import 'package:madrasati_plus/helper/gap.dart';

class LookingForSchool extends StatelessWidget {
  const LookingForSchool({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customtext(text: "start looking using", size: 30),
        gap(),

        CustomButton(
          text: "use my current location",
          onPressed: () {
            Navigator.pushNamed(context, "mylocation");
          },
        ),
        gap(),
        CustomButton(text: "enter location"),
      ],
    );
  }
}
