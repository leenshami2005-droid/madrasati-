import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrasati_plus/helper/snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _kAuthEmailDomain = 'myapp.internal';

String _shadowEmail(String raw) {
  final t = raw.trim();
  if (t.isEmpty) return t;
  return '$t@$_kAuthEmailDomain';
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String idNumber = '';
  String phoneNumber = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;
  String? idError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF2E4B82);
    final mq = MediaQuery.of(context);
    final screenH = mq.size.height;
    final topImageH = screenH * 0.4;
    final sheetH = screenH * 0.68;

    final borderColor = Colors.grey.shade300;
    final fieldDecoration = InputDecoration(
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(color: borderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: navy, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );

    Widget formContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: navy,
              borderRadius: BorderRadius.circular(11),
              child: InkWell(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pushReplacementNamed('welcome');
                  }
                },
                borderRadius: BorderRadius.circular(11),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: Text(
                    'رجوع',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'إنشاء حساب',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 35),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            textAlign: TextAlign.right,
            onChanged: (value) {
              idNumber = value;
              setState(() {
                if (value.isEmpty) {
                  idError = null;
                } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  idError = 'الرجاء إدخال الرقم الوطني مكوناً من 10 أرقام';
                } else {
                  idError = null;
                }
              });
            },
            decoration: fieldDecoration.copyWith(
              hintText: 'الرقم الوطني',
              errorText: idError,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.right,
            onChanged: (value) {
              phoneNumber = value;
            },
            decoration: fieldDecoration.copyWith(
              hintText: 'رقم الهاتف',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            textAlign: TextAlign.right,
            obscureText: true,
            onChanged: (value) {
              password = value;
              if (passwordError != null) {
                setState(() {
                  passwordError = null;
                });
              }
            },
            decoration: fieldDecoration.copyWith(
              hintText: 'كلمة المرور',
              errorText: passwordError,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            textAlign: TextAlign.right,
            obscureText: true,
            onChanged: (value) {
              confirmPassword = value;
              if (confirmPasswordError != null) {
                setState(() {
                  confirmPasswordError = null;
                });
              }
            },
            decoration: fieldDecoration.copyWith(
              hintText: 'تأكيد كلمة المرور',
              errorText: confirmPasswordError,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: ElevatedButton(
              onPressed: isLoading ? null : () => _handleSignup(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                disabledBackgroundColor: navy.withValues(alpha: 0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'GraphikArabic',
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Divider(color: borderColor, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'أو',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ),
              Expanded(child: Divider(color: borderColor, thickness: 1)),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                                  SvgPicture.asset(
                    'assets/imgs/sanad_logo.svg',
                                      height: 24,
                    width: 24,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.verified_user_rounded,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    ),

                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'إنشاء حساب مع سند',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'GraphikArabic',
                    ),
                  ),
                ],
              ),
            ),
          ),
           SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('لديك حساب بالفعل؟ ', style: TextStyle(fontSize: 14)),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, 'login'),
                child:  Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Color(0xFF2E4B82),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mq.padding.bottom + 24),
        ],
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: topImageH,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      'assets/imgs/chairs.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: Color(0xFFF0F0F5)),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        width: 407.85,
                        child: SvgPicture.asset(
                          'assets/imgs/maqaddaklogo.svg',
                          height: 210,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: sheetH,
                padding: const EdgeInsets.fromLTRB(30, 28, 30, 0),
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 12)],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(63),
                    topLeft: Radius.circular(63),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: formContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignup(BuildContext context) async {
    setState(() {
      idError = null;
      passwordError = null;
      confirmPasswordError = null;
    });

    bool hasErrors = false;

    if (idNumber.isEmpty) {
      setState(() {
        idError = "الرجاء إدخال الرقم الوطني";
      });
      hasErrors = true;
    } else if (!RegExp(r'^\d{10}$').hasMatch(idNumber)) {
      setState(() {
        idError = "الرجاء إدخال الرقم الوطني مكوناً من 10 أرقام";
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
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _shadowEmail(idNumber),
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set(
          {
            'idNumber': idNumber.trim(),
            'phoneNumber': phoneNumber.trim(),
          },
          SetOptions(merge: true),
        );
      }

      setState(() {
        isLoading = false;
      });

      if (context.mounted) {
        sSnackbar.show(context, text: "تم إنشاء الحساب بنجاح");
        Navigator.pushNamed(context, "homepage");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "حدث خطأ";

      if (e.code == 'weak-password') {
        setState(() {
          passwordError = "كلمة المرور ضعيفة جداً";
        });
        errorMessage = "كلمة المرور ضعيفة جداً";
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          idError = "الرقم الوطني مستخدم بالفعل";
        });
        errorMessage = "الرقم الوطني مستخدم بالفعل";
      } else if (e.code == 'invalid-email') {
        setState(() {
          idError = "الرقم الوطني غير صحيح";
        });
        errorMessage = "الرقم الوطني غير صحيح";
      }
      setState(() {
        isLoading = false;
      });

      if (context.mounted) {
        sSnackbar.show(context, text: errorMessage);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (context.mounted) {
        sSnackbar.show(context, text: "حدث خطأ غير متوقع");
      }
    }
  }
}