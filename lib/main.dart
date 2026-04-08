import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/registration/confirm.dart';
import 'package:madrasati_plus/pages/registration/registrationstep5.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/findschools.dart';
import 'package:madrasati_plus/pages/homepage/homepage.dart';
import 'package:madrasati_plus/pages/registration/registrationStep2.dart';
import 'package:madrasati_plus/pages/registration/registrationstep1.dart';
import 'package:madrasati_plus/pages/login2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:madrasati_plus/pages/services/services.dart';
import 'package:madrasati_plus/pages/signup2.dart';
import 'package:madrasati_plus/pages/welcome.dart';
import 'package:madrasati_plus/pages/my_child/my_child_page.dart';
import 'package:madrasati_plus/pages/my_account/my_account_page.dart';
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
      theme: ThemeData(
        fontFamily: "GraphikArabic",
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontWeight: FontWeight.w500),
          labelSmall: TextStyle(fontWeight: FontWeight.w500),
          labelMedium: TextStyle(fontWeight: FontWeight.w500),
          labelLarge: TextStyle(fontWeight: FontWeight.w500),
          displaySmall: TextStyle(fontWeight: FontWeight.w500),
          displayMedium: TextStyle(fontWeight: FontWeight.w500),
          displayLarge: TextStyle(fontWeight: FontWeight.w500),
          headlineSmall: TextStyle(fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(fontWeight: FontWeight.w500),
          headlineLarge: TextStyle(fontWeight: FontWeight.w500),
          titleSmall: TextStyle(fontWeight: FontWeight.w500),
          titleMedium: TextStyle(fontWeight: FontWeight.w500),
          titleLarge: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      debugShowCheckedModeBanner: false,

      routes: {
        "login": (context) => LoginScreen(),
        "welcome": (context) => WelcomeScreen(),
        "homepage": (context) => HomePage(),
        "signup": (context) => SignupScreen(),
        "registration" :(context) =>RegisterStep1Page(),
        "step2" : (context) => Registrationstep2(),
        "findschool" : (context) => const findschools(),
        "confirm" : (context) => Confirm(),
        "step5" : (context) => RegistrationStep5(),
        "mychild": (context) => const MyChildPage(),
        "services": (context) => const ServicesPage(),
        "myaccount": (context) => const MyAccountPage(),
      },

      initialRoute: "login",
    );
  }
}
