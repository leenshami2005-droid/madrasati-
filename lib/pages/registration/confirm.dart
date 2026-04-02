import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';

class Confirm extends StatelessWidget {
  const Confirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text('تسجيل الطالب',textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      
                    
                
                  const SizedBox(height: 16),
                   RegistrationProgressBar(currentStep: 4),
                
            ]
                
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2, onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, 'homepage');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, 'findschool');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, 'registration');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, 'step2');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, 'welcome');
            break;
        }
      },),
    );
  }
}