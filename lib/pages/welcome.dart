import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/imgs/chairs.png', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                const Text(
                  "مقعدك",
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "لأن وقتك أهم من أي طابور",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const Spacer(flex: 2),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "login");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E4B82),
                    disabledBackgroundColor: const Color(0xFF2E4B82),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("تسجيل دخول", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                const SizedBox(height: 15),
                // Create Account Button
                ElevatedButton(
                  onPressed: (){Navigator.pushNamed(context, "signup");},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E4B82),
                    disabledBackgroundColor: const Color(0xFF2E4B82),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("انشاء حساب", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                const SizedBox(height: 20),
                const Text("أو", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                // Third Party Login
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A315F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text("تسجيل دخول مع إسناد", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4, // الملف الشخصي
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