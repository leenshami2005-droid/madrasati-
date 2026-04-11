import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';
import 'package:madrasati_plus/pages/registration/registration_header.dart';
import 'package:madrasati_plus/pages/registration/registration_nav_buttons.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/state/registration_draft.dart';

class RegisterStep1Page extends StatefulWidget {
  const RegisterStep1Page({Key? key}) : super(key: key);

  @override
  State<RegisterStep1Page> createState() => _RegisterStep1PageState();
}

class _RegisterStep1PageState extends State<RegisterStep1Page> {
  int currentStep = 1;
  String? gender;
  String? grade;
  bool transferred = false;
  bool specialNeeds = false;
  DateTime? birthDate;

  final nameController = TextEditingController();
  final idController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2015),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => birthDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final grayBorder = Color(0xffB3B3B3);

    InputDecoration _fieldDecoration(String hint) => InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          enabledBorder: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF233B72)),
            borderRadius: BorderRadius.zero,
          ),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const RegistrationStepHeader(showBack: false),

              const SizedBox(height: 16),
               RegistrationProgressBar(currentStep: currentStep),

              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'بيانات الطفل',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GraphikArabic',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: grayBorder),
                        ),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "الاسم",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: nameController,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'GraphikArabic',
                                    ),
                                    decoration: _fieldDecoration('أدخل الاسم'),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            
                            Divider(height: 2,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "الرقم الوطني",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: idController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'GraphikArabic',
                                    ),
                                    decoration: _fieldDecoration('أدخل الرقم الوطني'),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                           Divider(height: 2),
               

                            
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "تاريخ الميلاد",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _selectDate(context),
                                    child: InputDecorator(
                                      decoration: _fieldDecoration('اختر التاريخ'),
                                      child: Text(
                                        birthDate == null
                                            ? ''
                                            : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'GraphikArabic',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF40403F),
                                  size: 24,
                                ),
                              ],
                            ),






                            Divider(height: 2),
                            
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "الجنس",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    initialValue: gender,
                                    isExpanded: true,
                                    alignment: Alignment.centerLeft,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    items: const [
                                      DropdownMenuItem(value: 'ذكر', child: Text('ذكر')),
                                      DropdownMenuItem(value: 'أنثى', child: Text('أنثى')),
                                    ],
                                    onChanged: (v) => setState(() => gender = v),
                                  ),
                                ),
                              ],
                            ),
                         Divider(height: 2),

                            
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "الصف",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    initialValue: grade,
                                    isExpanded: true,
                                    decoration: _fieldDecoration(' '),
                                    items: const [
                                      DropdownMenuItem(value: 'الأول', child: Text('الأول')),
                                      DropdownMenuItem(value: 'الثاني', child: Text('الثاني')),
                                      DropdownMenuItem(value: 'الثالث', child: Text('الثالث')),
                                      DropdownMenuItem(value: 'الرابع', child: Text('الرابع')),
                                      DropdownMenuItem(value: 'الخامس', child: Text('الخامس')),
                                      DropdownMenuItem(value: 'السادس', child: Text('السادس')),
                                      DropdownMenuItem(value: 'السايع', child: Text('السايع')),
                                      DropdownMenuItem(value: 'الثامن', child: Text('الثامن')),
                                      DropdownMenuItem(value: 'التاسع', child: Text('التاسع')),
                                      DropdownMenuItem(value: 'العاشر', child: Text('العاشر')),
                                      DropdownMenuItem(value: 'الاول ثانوي', child: Text('الاول ثانوي')),
                                      DropdownMenuItem(value: 'الثاني ثنوي', child: Text('الثاني ثنوي')),
                                    ],
                                    onChanged: (v) => setState(() => grade = v),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 24),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: grayBorder, width: 1),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              child: _buildChoiceBox(
                                'هل تم نقل الطفل من مدرسة أخرى؟',
                                [('لا، طالب جديد', false), ('نعم، منقول', true)],
                                transferred,
                                (v) => setState(() => transferred = v),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

                              child: _buildChoiceBox(
                                'هل لدى الطفل احتياجات خاصة؟',
                                [
                                  ('لا توجد احتياجات خاصة', false),
                                  ('نعم، لديه احتياجات خاصة', true)
                                ],
                                specialNeeds,
                                (v) => setState(() => specialNeeds = v),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                child: RegistrationNavButtons(
                  onNext: () {
                    final draft = RegistrationDraft.instance;
                    draft.childName = nameController.text.trim();
                    draft.nationalId = idController.text.trim();
                    draft.birthDate = birthDate;
                    draft.gender = gender;
                    draft.grade = grade;
                    draft.transferred = transferred;
                    draft.specialNeeds = specialNeeds;

                    Navigator.pushNamed(context, 'step2');
                  },
                  nextLabel: 'التالي',
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 1, // التسجيل
        ),
      ),
    );
  }

  Widget _buildChoiceBox(String title, List<(String, bool)> options,
      bool selected, Function(bool) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'GraphikArabic',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0x80D9D9D9),
            borderRadius: BorderRadius.circular(11),
          ),
          padding: const EdgeInsets.all(2),
          child: Row(
            children: options.map((opt) {
              final (label, value) = opt;
              final active = selected == value;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onSelect(value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: active ? Colors.black.withOpacity(.7) : Colors.transparent,
                          blurRadius: 2.5,
                          spreadRadius: 0,
                          offset: const Offset(0, 2),
                        )
                      ],
                      color: active ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'GraphikArabic',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// ======= Reusable Progress Bar with colored segments =======
