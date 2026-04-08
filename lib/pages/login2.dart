import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:madrasati_plus/helper/snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Firebase auth email uses the user ID as a shadow address.
/// Example: "123456789@myapp.internal".
const String _kAuthEmailDomain = 'myapp.internal';

String _shadowEmail(String raw) {
  final t = raw.trim();
  if (t.isEmpty) return t;
  return '$t@$_kAuthEmailDomain';
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _idError;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Match signup2.dart: chairs band + overlapping white sheet.
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
            'تسجيل الدخول',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 35),
          TextField(
            controller: _idController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            textAlign: TextAlign.right,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  _idError = null;
                } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  _idError = 'الرجاء إدخال رقم وطني صالح مكون من 10 أرقام';
                } else {
                  _idError = null;
                }
              });
            },
            decoration: fieldDecoration.copyWith(
              hintText: 'الرقم الوطني',
              errorText: _idError,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            textAlign: TextAlign.right,
            obscureText: true,
            decoration: fieldDecoration.copyWith(
              hintText: 'كلمة السر',
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: navy,
              ),
              child: const Text(
                'نسيت كلمة السر ؟',
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF2E4B82),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: ElevatedButton(
              onPressed: _isLoading ? null : () => _handleLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                disabledBackgroundColor: navy.withValues(alpha: 0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'تسجيل دخول',
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
                    'تسجيل دخول مع سند',
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
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ليس لديك حساب؟ ', style: TextStyle(fontSize: 14)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'signup'),
                child: const Text(
                  'إنشاء حساب',
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
                decoration:  BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 12)],
                  color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(63),topLeft: Radius.circular(63))
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

  Future<void> _handleLogin(BuildContext context) async {
    final idRaw = _idController.text.trim();
    final password = _passwordController.text;

    if (idRaw.isEmpty) {
      setState(() {
        _idError = 'الرجاء إدخال الرقم الوطني';
      });
      return;
    }

    if (!RegExp(r'^\d{10}$').hasMatch(idRaw)) {
      setState(() {
        _idError = 'الرجاء إدخال رقم وطني صالح مكون من 10 أرقام';
      });
      return;
    }

    if (password.isEmpty) {
      sSnackbar.show(context, text: 'الرجاء إدخال كلمة السر');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final email = _shadowEmail(idRaw);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!context.mounted) return;
      setState(() => _isLoading = false);
      Navigator.pushNamed(context, 'homepage');
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        setState(() => _isLoading = false);
        if (e.code == 'invalid-credential') {
          sSnackbar.show(context, text: 'البيانات غير صحيحة');
        } else if (e.code == 'wrong-password') {
          sSnackbar.show(context, text: 'كلمة السر غير صحيحة');
        } else if (e.code == 'user-not-found') {
          sSnackbar.show(context, text: 'المستخدم غير موجود');
        } else if (e.code == 'invalid-email') {
          sSnackbar.show(context, text: 'صيغة البريد أو الرقم غير صحيحة');
        } else {
          sSnackbar.show(context, text: 'تعذر تسجيل الدخول');
        }
      }
    } catch (_) {
      if (context.mounted) {
        setState(() => _isLoading = false);
        sSnackbar.show(context, text: 'حدث خطأ');
      }
    }
  }
}
