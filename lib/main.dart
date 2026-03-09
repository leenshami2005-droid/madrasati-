import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/account_type.dart';
import 'package:madrasati_plus/pages/homepage.dart';
import 'package:madrasati_plus/pages/login.dart';
import 'package:madrasati_plus/pages/looking_for_school.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:madrasati_plus/pages/schoollist.dart';
import 'package:madrasati_plus/pages/sign_up.dart';
import 'package:madrasati_plus/pages/usemycurrentlocation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "font1"),
      debugShowCheckedModeBanner: false,

      routes: {
        "login": (context) => Login(),
        "account_type": (context) => AccountType(),
        "homepage": (context) => Homepage(),
        "looking_for_school": (context) => LookingForSchool(),
        "signup": (context) => signup(),
        "mylocation": (context) => currentlocation(),
        "schoolslist": (context) => schoolslist(),
      },

      initialRoute: "account_type",
    );
  }
}
