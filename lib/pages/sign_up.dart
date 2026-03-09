import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/custom_textfield.dart';
import 'package:madrasati_plus/helper/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatelessWidget {
  signup({super.key});
  String id = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: ListView(
          children: [
            Container(
              height: 200,
              child: Image.asset(
                "assets/imgs/madrasatilogo.png",
                width: 300,
                height: 200,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "signup to create account",
                  style: TextStyle(
                    fontFamily: "font1",
                    fontSize: 20,
                    color: Colors.black,

                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            CustomTextFormField(
              hinttext: "enter your id",
              onchanged: (value) {
                id = value;
              },
            ),
            CustomTextFormField(
              hinttext: "enter your password",
              onchanged: (value) {
                password = value;
              },
            ),
            Container(
              alignment: Alignment.center,

              child: CustomButton(
                text: "signup",
                onPressed: () async {
                  try {
                    UserCredential user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: id,
                          password: password,
                        );

                    Navigator.pushNamed(context, "homepage");
                  } catch (e) {
                    print("error");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
