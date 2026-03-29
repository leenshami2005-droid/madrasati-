import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:madrasati_plus/helper/snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Pattern
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Opacity(opacity: 0.8, child: Image.asset('assets/imgs/chairs.png', fit: BoxFit.cover)),
          ),
          // Form Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text("إنشاء حساب", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 25),
                    CustomTextField(
                      hint: "الرقم الوطني أو البريد الإلكتروني",
                      errorText: emailError,
                      onChanged: (value) {
                        email = value;
                        if (emailError != null) {
                          setState(() {
                            emailError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hint: "كلمة المرور",
                      obscureText: true,
                      errorText: passwordError,
                      onChanged: (value) {
                        password = value;
                        if (passwordError != null) {
                          setState(() {
                            passwordError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hint: "تأكيد كلمة المرور",
                      obscureText: true,
                      errorText: confirmPasswordError,
                      onChanged: (value) {
                        confirmPassword = value;
                        if (confirmPasswordError != null) {
                          setState(() {
                            confirmPasswordError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: isLoading ? null : () => _handleSignup(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E4B82), minimumSize: const Size(double.infinity, 50)),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text("إنشاء حساب", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("لديك حساب بالفعل؟ "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "تسجيل الدخول",
                            style: TextStyle(color: Color(0xFF2E4B82), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(child: Text("مقعدك", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignup(BuildContext context) async {
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
    });

    bool hasErrors = false;

    if (email.isEmpty) {
      setState(() {
        emailError = "الرجاء إدخال البريد الإلكتروني";
      });
      hasErrors = true;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "الرجاء إدخال كلمة المرور";
      });
      hasErrors = true;
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordError = "الرجاء تأكيد كلمة المرور";
      });
      hasErrors = true;
    } else if (password != confirmPassword) {
      setState(() {
        confirmPasswordError = "كلمات المرور غير متطابقة";
      });
      hasErrors = true;
    }

    if (hasErrors) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
setState(() {
          isLoading = false;
        });
       
        sSnackbar.show(context, text: "تم إنشاء الحساب بنجاح");
         Navigator.pushNamed(context, "homepage");
         
        
      
    } on FirebaseAuthException catch (e) {
      String errorMessage = "حدث خطأ";

      if (e.code == 'weak-password') {
        setState(() {
          passwordError = "كلمة المرور ضعيفة جداً";
        });
        errorMessage = "كلمة المرور ضعيفة جداً";
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          emailError = "البريد الإلكتروني مستخدم بالفعل";
        });
        errorMessage = "البريد الإلكتروني مستخدم بالفعل";
      } else if (e.code == 'invalid-email') {
        setState(() {
          emailError = "البريد الإلكتروني غير صحيح";
        });
        errorMessage = "البريد الإلكتروني غير صحيح";
      }
      setState(() {
          isLoading = false;
        });

      sSnackbar.show(context, text: errorMessage);
    } catch (e) {
      sSnackbar.show(context, text: "حدث خطأ غير متوقع");
    } 
    }
    
  }


class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.right,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: errorText != null
              ? const BorderSide(color: Colors.red, width: 1)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: errorText != null
              ? const BorderSide(color: Colors.red, width: 2)
              : const BorderSide(color: Color(0xFF2E4B82), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}