import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/custombutton.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          Image.asset("assets/imgs/madrasatilogo.png", width: 300, height: 200),
          Spacer(flex: 1),

          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              "account type",
              style: TextStyle(
                fontFamily: "font1",
                fontSize: 20,
                color: Colors.black,

                decoration: TextDecoration.none,
              ),
            ),
          ),
          CustomButton(
            text: "looking for school",
            onPressed: () {
              Navigator.pushNamed(context, "looking_for_school");
            },
          ),
          SizedBox(height: 10),
          CustomButton(
            text: "login to school account",
            onPressed: () {
              Navigator.pushNamed(context, "login");
            },
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
