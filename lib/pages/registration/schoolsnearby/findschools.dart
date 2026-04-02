import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madrasati_plus/colors.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/models/schools.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/getlonglat.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/schoolcard.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/schoolsnearby.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/state/registration_draft.dart';

class findschools extends StatefulWidget {

   findschools({super.key});

  @override
  State<findschools> createState() => _findschoolsState();
}

class _findschoolsState extends State<findschools> {
  Position? userPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Position? position = await mylocation.getCurrentPosition();
    if (mounted) {
      setState(() {
        userPosition = position;
      });
    }
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Directionality(textDirection: TextDirection.rtl, child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(" تسجيل الطالب",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.black),textAlign: TextAlign.right,),
            gap(height: 10),
            RegistrationProgressBar(currentStep: 3),
            gap(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "ابحث عن مدرستك",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.search),

              ),
            ),


          
              


            
            gap(height: 20),
            Expanded(
              child: userPosition != null 
                ? nearschools(
                    userLat: userPosition!.latitude, 
                    userLong: userPosition!.longitude
                  )
                : const Center(child: CircularProgressIndicator()),
            ),

        gap(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              width: 93,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'رجوع',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                            gap(width: 15,),
                            Container(
                              width: 210,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  
                                  backgroundColor: blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  final d = RegistrationDraft.instance;
                                  if (d.selectedSchoolName == null ||
                                      d.selectedSchoolName!.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'يرجى اختيار مدرسة من القائمة',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  Navigator.pushReplacementNamed(context, 'confirm');
                                },
                                child: const Text(
                                  'التالي',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
gap(height: 30,)
          ],
        
          
        ),
      ),
        
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // الخدمات
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