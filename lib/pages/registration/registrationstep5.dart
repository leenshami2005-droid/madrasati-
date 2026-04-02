import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';

class RegistrationStep5 extends StatelessWidget {
  const RegistrationStep5({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF233B72);
    const Color outline = Color(0xFFD9D9D9);

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تسجيل الطالب',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),

                const RegistrationProgressBar(currentStep: 5),
                const SizedBox(height: 18),

                // ===== Big Success Icon =====
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: outline, width: 4),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 60,
                      color: primary,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: Text(
                    'تم إرسال الطلب',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'استلمنا طلبك بنجاح، محافظ على تلقي إشعار القبول بعد دراسة الطلب.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ===== REG Card =====
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/imgs/whitechair.svg',
                        width: 52,
                        height: 52,
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'رقم الطلب',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'REG-2026-04821',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ===== Status Card =====
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: outline),
                  ),
                  child: Column(
                    children: [
                      _StatusRow(
                        badge: const _Badge(
                          text: 'س',
                          color: Color(0xFF233B72),
                          textColor: Colors.white,
                        ),
                        title: 'سيتم استلام الطلب',
                        subtitle: 'خلال 7 أيام عمل',
                      ),
                      const Divider(height: 26, color: outline),
                      _StatusRow(
                        badge: const _Badge(
                          text: '١',
                          color: Color(0xFFE7E7E7),
                          textColor: Color(0xFF7A7A7A),
                        ),
                        title: 'اجراءات الدراسة',
                        subtitle: 'خلال أسبوع',
                      ),
                      const Divider(height: 26, color: outline),
                      _StatusRow(
                        badge: const _Badge(
                          text: '٢',
                          color: Color(0xFFE7E7E7),
                          textColor: Color(0xFF7A7A7A),
                        ),
                        title: 'إشعار القبول',
                        subtitle: 'عن طريق SMS',
                      ),
                      const Divider(height: 26, color: outline),
                      _StatusRow(
                        badge: const _Badge(
                          text: '٣',
                          color: Color(0xFFE7E7E7),
                          textColor: Color(0xFF7A7A7A),
                        ),
                        title: 'إتمام الاجراءات',
                        subtitle: 'بعد مراجعة الطلب',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'نصائح: يرجى متابعة إشعارات التطبيق وعدم مشاركة بيانات الطلب.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.35),
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ===== Buttons =====
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'step2');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'رجوع',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'homepage');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'التالي',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
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

class _StatusRow extends StatelessWidget {
  final Widget badge;
  final String title;
  final String subtitle;

  const _StatusRow({
    required this.badge,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        badge,
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const _Badge({
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

