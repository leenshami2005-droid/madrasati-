import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/findschools.dart';
import 'package:madrasati_plus/pages/homepage/homepage.dart';
import 'package:madrasati_plus/pages/registration/registrationStep2.dart';
import 'package:madrasati_plus/pages/registration/registrationstep1.dart';
import 'package:madrasati_plus/pages/login2.dart';
import 'package:madrasati_plus/pages/looking_for_school.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:madrasati_plus/pages/signup2.dart';
import 'package:madrasati_plus/pages/welcome.dart';
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
        "login": (context) => LoginScreen(),
        "welcome": (context) => WelcomeScreen(),
        "homepage": (context) => HomePage(),
        "looking_for_school": (context) => LookingForSchool(),
        "signup": (context) => SignupScreen(),
        "registration" :(context) =>RegisterStep1Page(),
        "step2" : (context) => Registrationstep2(),
        "findschool" : (context) => findschools(),
      },

      initialRoute: "welcome",
    );
  }
}
