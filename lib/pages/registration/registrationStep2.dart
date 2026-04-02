import 'package:flutter/material.dart';
import 'package:madrasati_plus/colors.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';

class Registrationstep2 extends StatefulWidget {
  const Registrationstep2({Key? key}) : super(key: key);

  @override
  State<Registrationstep2> createState() => _Registrationstep2State();
}

class _Registrationstep2State extends State<Registrationstep2> {
  @override
  Widget build(BuildContext context) {
    final grayBorder = Color(0xffB3B3B3); // Local fallback if needed

    InputDecoration _fieldDecoration(String hint) => InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w200),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          enabledBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(borderSide: const BorderSide(color: Color(0xff2A3F6F))),
          filled: true,
          fillColor: Colors.white,
        );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  gap(width: 20),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const Text(
                    'تسجيل الطالب',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RegistrationProgressBar(currentStep: 2, currentLineProgress: 0.25),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'مستندات الزامية',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: grayBorder, width: 1),
                        ),
                        child: Column(
                          children: [
                            _buildDocumentRow("شهادة ميلاد الطفل"),
                            Divider(color: grayBorder, height: 1),
                            _buildDocumentRow("سجل التطعيم"),
                          ],
                        ),
                      ),
                      gap(height: 24),
                      const Text(
                        'مستندات غير إلزامية',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: grayBorder, width: 1),
                        ),
                        child: Column(
                          children: [
                            _buildDocumentRow("شهادة نقل"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        "إذا كان الطفل منقولاً من مدرسة أخرى، ستحتاج إلى إرفاق شهادة نقل معتمدة من المدرسة السابقة.",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff2A3F6F),
                          fontWeight: FontWeight.w100,
                          fontFamily: "font2",
                        ),
                      ),
                      const Divider(),
                      Text(
                        "يجب أن تكون جميع المستندات واضحة وغير منتهية الصلاحية. الصيغ المقبولة: PDF أو JPG أو PNG.",
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xff888888),
                          fontWeight: FontWeight.w100,
                          fontFamily: "font2",
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'findschool');
                          },
                          child: const Text(
                            'التالي',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 3, // step2 tab
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
      ),
    );
  }

  Widget _buildDocumentRow(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF233B72),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'تحميل',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

