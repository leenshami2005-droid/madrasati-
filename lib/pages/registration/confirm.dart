import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';
import 'package:madrasati_plus/pages/registration/registrationstep5.dart';

class Confirm extends StatelessWidget {
  const Confirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تسجيل الطالب',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const RegistrationProgressBar(currentStep: 4),

                const SizedBox(height: 18),

                // ===== School Nearby Card =====
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF233B72),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'المدرسة القريبة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'مدرسة الأمير راشد بن حسين',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'المنطقة: حي ... • الشارع: ...',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                          SvgPicture.asset("assets/imgs/whitechair.svg"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ===== Child Data =====
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE7E7E7)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'بيانات الطفل',
                        style: TextStyle(
                          color: Color(0xFF2A3F6F),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _KeyValueRow(label: 'الاسم', value: 'خليل محمد عبدالله'),
                      _KeyValueRow(label: 'الرقم الوطني', value: '9912034871'),
                      _KeyValueRow(label: 'تاريخ الميلاد', value: '12/03/2019'),
                      _KeyValueRow(label: 'الجنس', value: 'ذكر'),
                      _KeyValueRow(label: 'الصف', value: 'السابع'),
                      _KeyValueRow(label: 'المدرسة', value: 'المدرسة القريبة'),
                      _KeyValueRow(label: 'الأب', value: 'أحمد عطاع محمد'),
                      _KeyValueRow(
                        label: 'العنوان',
                        value: 'لا يوجد',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ===== Files Uploaded =====
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE7E7E7)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'بيانات الملف',
                        style: TextStyle(
                          color: Color(0xFF2A3F6F),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FilePill(
                        title: 'PDF - 1,3 MB',
                        subtitle: 'شهادة الميلاد',
                      ),
                      const SizedBox(height: 10),
                      _FilePill(
                        title: 'JPG - 1,4 MB',
                        subtitle: 'صورة الهوية',
                      ),

                      const SizedBox(height: 12),
                      Text(
                        'يرجى ارتياكا كافة البيانات قبل الإرسال. شكرا لثقتكم.',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.75),
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ===== Buttons =====
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'step2');
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2A3F6F)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'رجوع',
                          style: TextStyle(
                            color: Color(0xFF2A3F6F),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegistrationStep5(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF233B72),
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
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 3, onTap: (index) {
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

class _KeyValueRow extends StatelessWidget {
  final String label;
  final String value;

  const _KeyValueRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilePill extends StatelessWidget {
  final String title;
  final String subtitle;

  const _FilePill({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF5AA469), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}