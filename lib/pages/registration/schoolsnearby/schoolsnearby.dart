import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madrasati_plus/models/schools.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/schoolcard.dart';
   List<Schoolmodel> schoolslist = [];

class nearschools extends StatelessWidget {
   nearschools({super.key});
CollectionReference schools = FirebaseFirestore.instance.collection('schools');
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: schools.snapshots(), 
      builder: (BuildContext context,  snapshot) {
        if(snapshot.hasError){
          return Text("something went wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
 return CircularProgressIndicator();        }
if(snapshot.hasData){
  for(int i=0 ;i<snapshot.data!.docs.length;i++){

        schoolslist.add(Schoolmodel.fromJson(snapshot.data!.docs[i]));
  }
  return ListView.builder(itemBuilder: (context, index) {
    return Schoolslistcard(schoolname: schoolslist[index].title, schoollocation: schoolslist[index].address,);
  }, itemCount: schoolslist.length,);
}
return Text("no nearschools found..try to search for schools in another location");
});}}