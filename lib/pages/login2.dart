import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:madrasati_plus/helper/snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
String id= "";
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset('assets/imgs/chairs.png', fit: BoxFit.cover),
            ),
          ),
          // White Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  const Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      id = value;
                    },
                    decoration: const InputDecoration(hintText: "الرقم الوطني", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    textAlign: TextAlign.right,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(hintText: "كلمة السر", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  const SizedBox(height: 10),
                  const Align(alignment: Alignment.centerRight, child: Text("نسيت كلمة السر؟", style: TextStyle(color: Color(0xFF2E4B82)))),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: isLoading ? null : () => _handleLogin(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E4B82), minimumSize: const Size(double.infinity, 50)),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text("تسجيل دخول", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("ليس لديك حساب؟ "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "signup");
                        },
                        child: const Text(
                          "إنشاء حساب",
                          style: TextStyle(color: Color(0xFF2E4B82), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Floating Logo Text
           Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Container(
              height: 250,width: 300,
              child: SvgPicture.asset("assets/imgs/maqaddaklogo.svg" ,)),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4, // الملف الشخصي
        
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await login(id, password);
       Navigator.pushNamed(context, "homepage");
       
       
        
      setState(() {
          isLoading = false;
        });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        sSnackbar.show(context, text: "البيانات غير صحيحة");
      } else if (e.code == 'wrong-password') {
        sSnackbar.show(context, text: "كلمة السر غير صحيحة");
      } else if (e.code == 'user-not-found') {
        sSnackbar.show(context, text: "المستخدم غير موجود");
      }

       setState(() {
      isLoading = false;
    });
    } catch (e) {
      sSnackbar.show(context, text: "حدث خطأ");
    }
    }
  }

  Future<void> login(String id, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: id, password: password);
  }
