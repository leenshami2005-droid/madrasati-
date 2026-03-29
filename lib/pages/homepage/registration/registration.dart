import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/gap.dart';

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
    const blue =Color(0xff2A3F6F);
    final grayBorder = Color(0xffB3B3B3);

    InputDecoration _fieldDecoration(String hint) => InputDecoration(
          hintText: hint,
          hintStyle:  TextStyle(color: Colors.grey, fontSize: 15,fontWeight: FontWeight.w200),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          enabledBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff2A3F6F))),
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
              _ProgressBar(currentStep: currentStep),
              const SizedBox(height: 16),
              const Text('تسجيل الطالب',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('بيانات الطفل',
                          style: TextStyle(
                              fontSize: 18,fontWeight:FontWeight.w400)),
                      const SizedBox(height: 18),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: BoxBorder.all(color:grayBorder, width: 1)
                        ),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("الاسم", style: TextStyle(fontWeight:FontWeight.w400),),
                                Container(
                                  width: 300,
                                  child: TextField(
                                    controller: nameController,
                                    decoration: _fieldDecoration('أدخل الاسم'),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            
                            Divider(height: 2,),

                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,

                              children: [
                                Text("الرقم الوطني", style: TextStyle(fontWeight:FontWeight.w400)),
                                Container(
                                  width: 300,
                                  child: TextField(
                                    controller: idController,
                                    keyboardType: TextInputType.number,
                                    decoration: _fieldDecoration('أدخل الرقم الوطني'),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                           Divider(height: 2),
               

                            
                            Row(
                              children: [
                                gap(width: 20,),
                                Text("تاريخ الميلاد", style: TextStyle(fontWeight:FontWeight.w400)),
                                gap(width: 27,),
                                Container(
                                  
                                  
                                  width: 300,
                                  child: InkWell(
                                    onTap: () => _selectDate(context),
                                    child: InputDecorator(
                                      decoration: _fieldDecoration(''),
                                      child: Row(
                                        children: [
                                          Text(
                                            birthDate == null
                                                ? ''
                                                : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(fontSize: 15),
                                          ),  

                                        ],
                                      ),
                                    ),
                                  ),
                                ),   Icon(Icons.arrow_drop_down ,color: Color.fromARGB(255, 64, 63, 63),),

                              ],
                            ),








                            Divider(height: 2),
                            
                            Row(

                              children: [
                                gap(width: 20,),
                                Text("الجنس",textAlign: TextAlign.right,style: TextStyle(fontWeight:FontWeight.w400)),
                                gap(width: 80,),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: 300,
                                  child: DropdownButtonFormField<String>(
                                    alignment: Alignment.centerLeft,
                                    decoration: InputDecoration(
                                      
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                    
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
                              children: [
                                gap(width: 20,),
                                Text("الصف", style: TextStyle(fontWeight:FontWeight.w400)),
                                gap(width: 59,),
                                Container(
                                  width: 340,
                                  child: DropdownButtonFormField<String>(
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
                          border: BoxBorder.all(color: grayBorder ,width: 1),
                          borderRadius: BorderRadius.circular(11)
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: _buildChoiceBox(
                                'هل تم نقل الطفل من مدرسة أخرى؟',
                                [('لا، طالب جديد', false), ('نعم، منقول', true)],
                                transferred,
                                (v) => setState(() => transferred = v),
                              ),
                            ),
                            const SizedBox(height: 14),
                            
                            _buildChoiceBox(
                              'هل لدى الطفل احتياجات خاصة؟',
                              [
                                ('لا توجد احتياجات خاصة', false),
                                ('نعم، لديه احتياجات خاصة', true)
                              ],
                              specialNeeds,
                              (v) => setState(() => specialNeeds = v),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

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
                          onPressed: () {},
                          child: const Text('التالي',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
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
      ),
    );
  }

  Widget _buildChoiceBox(String title, List<(String, bool)> options,
      bool selected, Function(bool) onSelect) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
                          color:Color(0x80D9D9D9) ,

              borderRadius: BorderRadius.circular(11)
            ),
            child: Row(
              children: options.map((opt) {
                final (label, value) = opt;
                final active = selected == value;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onSelect(value),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                        boxShadow:[BoxShadow(
                          color: active ? Colors.black.withOpacity(.7) : Colors.transparent,
                          blurRadius: 2.5,  
                     spreadRadius: 0, 
        offset: const Offset(0, 2),
                        )] ,
                        color: active ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(child: Text(label)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ======= Reusable Progress Bar with colored segments =======
class _ProgressBar extends StatelessWidget {
  final int currentStep;
  const _ProgressBar({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2A3F6F);
    final gray = Colors.grey.shade300;
    const steps = ['بيانات الطفل', 'المستندات', 'المدرسة', 'المراجعة', 'التأكيد'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: List.generate(steps.length - 1, (i) {
                    final active = i < currentStep - 1;
                    return Expanded(
                      child: Container(height: 2, color: active ? blue : gray),
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(steps.length, (i) {
                    final active = i == currentStep - 1;
                    return Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: active ? blue : Colors.white,
                        border: Border.all(
                            color: active ? blue : Colors.grey.shade400, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: active ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (i) {
              final active = i == currentStep - 1;
              return Text(
                steps[i],
                style: TextStyle(
                  fontSize: 12,
                  color: active ? blue : Colors.grey.shade500,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
