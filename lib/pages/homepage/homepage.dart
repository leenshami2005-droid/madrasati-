import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/pages/homepage/absence_card.dart';
import 'package:madrasati_plus/pages/homepage/registrationcard.dart';


class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedStudentType = 'طالب جديد';
  bool isloading = false;
  int _selectedChildIndex = 0;
  int selectedCalendarDayIndex = 0;
  final CollectionReference student =
      FirebaseFirestore.instance.collection("students");

  String? _currentParentId() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email == null || !email.contains('@')) return null;
    return email.split('@').first.trim();
  }

  bool _matchesParent(String? parentId, Map<String, dynamic> data) {
    if (parentId == null) return false;
    final dataParent = data['parentId'] ?? data['parentid'] ?? data['parent_id'];
    if (dataParent == null) return false;
    return dataParent.toString().trim() == parentId;
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: student.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'حدث خطأ في تحميل البيانات:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final parentId = _currentParentId();
        final allDocs = snapshot.data?.docs ?? const <QueryDocumentSnapshot>[];
        final studentDocs = allDocs
            .where((doc) =>
                _matchesParent(parentId, doc.data() as Map<String, dynamic>))
            .toList();

        final hasChildren = studentDocs.isNotEmpty;

        if (_selectedChildIndex >= studentDocs.length) {
          _selectedChildIndex = 0;
        }

        final doc = hasChildren ? studentDocs[_selectedChildIndex] : null;
        final studentName =
            hasChildren ? (doc!["name"]?.toString() ?? '') : '';
        final totalAbsence = hasChildren ? (doc!["totabsence"] ?? 0) : 0;
        final monthAbsence = hasChildren ? (doc!["absense-month"] ?? 0) : 0;
        final attendance = hasChildren ? (doc!["attendance"] ?? 0) : 0;
        final late = hasChildren ? (doc!["late"] ?? 0) : 0;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header with greeting
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.notifications),
                          gap(width: 150,),
                          Row(
                            children: [
                              if (hasChildren)
                                Text(
                                  studentName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              Text(
                                "مرحبا بك ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textDirection: TextDirection.rtl,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        
                registrationcard(),
               
                 Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                     color: Color(0x4DC1C1C1),
                  ),
                
                
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.end,
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: hasChildren
                                    ? _selectedChildIndex.clamp(0, studentDocs.length - 1)
                                    : null,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                                hint: Text(
                                  parentId == null
                                      ? 'يرجى تسجيل الدخول'
                                      : 'لا يوجد أطفال',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                items: hasChildren
                                    ? [
                                        for (var i = 0; i < studentDocs.length; i++)
                                          DropdownMenuItem(
                                            value: i,
                                            child: Text(
                                              studentDocs[i]["name"]?.toString() ??
                                                  'طفل ${i + 1}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                      ]
                                    : const [],
                                onChanged: hasChildren
                                    ? (value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedChildIndex = value;
                                          });
                                        }
                                      }
                                    : null,
                              ),
                            ),
                          ),
                          Text(
                            "حالة الطالب",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'GraphikArabic',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Divider(
                        color:Color(0xffC1C1C1) ,
                        thickness: 1,
                        height: 15,
                        
                      ),
                    if (!hasChildren)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'لا يوجد أطفال مرتبطة بهذا الحساب',
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    GridView.count(
                      // Wider than tall (was 2:1) so each stat card has enough height.
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 50,
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        absencecard(
                          text: "اجمالي الغيابات ",
                          number: totalAbsence,
                        ),
                        absencecard(
                          text: "غيابات الشهر",
                          number: monthAbsence,
                        ),
                        absencecard(
                          text: "ايام الحضور",
                          number: attendance,
                        ),
                        absencecard(
                          text: " ايام التأخير",
                          number: late,
                        ),
                      ],
                    ),
                      Divider(
                        color:Color(0xffC1C1C1) ,
                        thickness: 1,
                        height: 15,
                        
                      ),
                    ],
        
        
                    
                  
                 ),), 
            
        
               
                
        
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                                      color: Color(0x4dc1c1c1),

                  ),
                  padding: EdgeInsets.all(10),
                  constraints: const BoxConstraints(minHeight: 122),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'إجراءات سريعة',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'GraphikArabic',
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QuickActionIcon(
                            pic: "assets/imgs/move.svg",
                            label: 'طلب نقل',
                          ),
                          QuickActionIcon(
                            pic: "assets/imgs/certificate.svg",
                            label: 'طلب الشهاده',
                          ),
                          QuickActionIcon(
                            pic: "assets/imgs/mostanad.svg",
                            label: 'طلب مستند',
                          ),
                          QuickActionIcon(
                            tap: () {
                              Navigator.pushNamed(context, "registration");
                            },
                            pic: "assets/imgs/reg.svg",
                            label: 'تسجيل طالب',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                Container(  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                                      color: Color(0x4dc1c1c1),

                  ),
                  padding: EdgeInsets.all(10),
                  constraints: const BoxConstraints(minHeight: 122),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [  Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          ' التنبيهات',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'GraphikArabic',
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),],
                  ),

                ),

        
           
        
                // Academic Calendar Section
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0x4dc1c1c1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'التقويم',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'GraphikArabic',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(7, (index) {
                            final date = DateTime.now().add(Duration(days: index));
                            const weekdayLabels = [
                              'الاثنين',
                              'الثلاثاء',
                              'الأربعاء',
                              'الخميس',
                              'الجمعة',
                              'السبت',
                              'الأحد',
                            ];
                            final label = weekdayLabels[date.weekday - 1];
                            final isSelected = selectedCalendarDayIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCalendarDayIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: index == 6 ? 0 : 12),
                                width: 78,
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF2E4B82) : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF2E4B82) : Colors.grey.shade300,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? Colors.white : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 0, // الرئيسية
          ),
        );
      }
    );
  }

 
}

class StatisticCard extends StatelessWidget {
  final String value;
  final String label;

  const StatisticCard({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const StatusButton({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class QuickActionIcon extends StatelessWidget {
  final String pic;
  final String label;
  final VoidCallback? tap;

   QuickActionIcon({
    super.key,
    required this.pic,
    required this.label,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
      width: 75.36, height: 57.46,
      decoration: BoxDecoration(
                      color:Color(0xffFFFFFF),
      
        borderRadius: BorderRadius.circular(11)
      ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              width: 16.96,
              height: 20.72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child:SvgPicture.asset(pic) ),
            
             SizedBox(height: 8),
            SizedBox(
              width: 70,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthButton extends StatelessWidget {
  final String month;

  const MonthButton({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        month,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}