import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/models/schools.dart';
import 'package:madrasati_plus/pages/looking_for_school.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/getlonglat.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/schoolcard.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/schoolsnearby.dart';
              List<Schoolmodel> nearbylist =[];
              int length = nearbylist.length;
class findschools extends StatefulWidget {

   findschools({super.key});

  @override
  State<findschools> createState() => _findschoolsState();
}

class _findschoolsState extends State<findschools> {
  mylocation mylocation1 = mylocation();

  @override
  void initState() {
    mylocation1.getcurrentlocation();
    super.initState();
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
            ListView.builder(itemBuilder: (context, index) {
              nearschools nearschools1 = nearschools();

               if(Geolocator.distanceBetween(mylocation().mylong, mylocation().mylat,schoolslist[index].longitude, schoolslist[index].latitude) <300){
nearbylist.add(schoolslist[index]);
                  return Container(
             width: 200,height: 70,
               child: nearschools1,
                      );
               }

          
            }, itemCount: length, shrinkWrap: true,),

          ],
        
          
        ),
      ),
        
      ),
    );
  }
}