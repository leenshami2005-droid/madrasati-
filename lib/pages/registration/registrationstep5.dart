import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';

class RegistrationStep5 extends StatelessWidget {
  const RegistrationStep5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_rounded, size: 64, color: Color(0xFF233B72)),
                const SizedBox(height: 12),
                const Text(
                  'تم إرسال الطلب',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF233B72),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'صفحة التسجيل - خطوة 5',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
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
        },
      ),
    );
  }
}

