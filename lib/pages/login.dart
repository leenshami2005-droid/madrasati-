import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/custom_textfield.dart';
import 'package:madrasati_plus/helper/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:madrasati_plus/helper/custotext.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/helper/snackbar.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';

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
                  "login to your account",
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
                text: "login",
                onPressed: () async {
                  try {
                    await login(id, password);
                    sSnackbar.show(context, text: "success");
                    Navigator.pushNamed(context, "homepage");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'invalid-credential') {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("wrong")));
                    } else if (e.code == 'wrong-password') {
                      sSnackbar.show(context, text: "wrong smth");
                    }
                  } catch (e) {
                    sSnackbar.show(context, text: "error ");
                  }
                },
              ),
            ),
            gap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customtext(text: "dont have account "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "signup");
                  },
                  child: customtext(text: "sign up", color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(String id, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: id, password: password);
  }
}
