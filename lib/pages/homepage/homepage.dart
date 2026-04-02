import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madrasati_plus/helper/gap.dart';
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
CollectionReference student =FirebaseFirestore.instance.collection("students");
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

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('لا توجد بيانات للطالب حتى الآن')),
          );
        }

        final doc = snapshot.data!.docs[0];
        final studentName = doc["name"];
        final totalAbsence = doc["totabsence"];
        final monthAbsence = doc["absense-month"];
        final attendance = doc["attendance"];
        final late = doc["late"];
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
                              Text(
                              studentName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textDirection: TextDirection.rtl,
                              ),Text("مرحبا بك ",textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textDirection: TextDirection.rtl,)
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
                      Text("حالة الطالب", textAlign: TextAlign.right,),
                   
                      Divider(
                        color:Color(0xffC1C1C1) ,
                        thickness: 1,
                        height: 15,
                        
                      ),
                    GridView.count(
                      childAspectRatio: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 50,
                      crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                  absencecard(text: "اجمالي الغيابات ", number: totalAbsence)    ,  
                  absencecard(text: "غيابات الشهر", number: monthAbsence)    ,           
                  absencecard(text: "ايام الحضور", number: attendance)    ,           
                  absencecard(text: " ايام التأخير", number: late)    ,           
                  
                    ],
                    
                    )
                    ,
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
                  height: 122,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'إجراءات سريعة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
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
                  height: 122,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [  Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          ' التنبيهات',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),],
                  ),

                ),

        
           
        
                // Academic Calendar Section
             
                const SizedBox(height: 30),
              ],
            ),
          ),
        
          // Bottom Navigation Bar
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: 3,
            items:  [

             
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'المفضلة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'الإعدادات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
              
              label: 'الملف الشخصي',

              ), BottomNavigationBarItem(
                icon: Icon(Icons.home),
               label: 'الرئيسية',

              ),
            ],
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
  VoidCallback? tap;

   QuickActionIcon({
    super.key,
    required this.pic,
    required this.label,
    this.tap
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