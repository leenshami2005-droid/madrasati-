import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/custombutton.dart';
import 'package:madrasati_plus/models/schools.dart';
import 'package:madrasati_plus/models/students.dart';

class schoolslist extends StatelessWidget {
  schoolslist({super.key});
  CollectionReference schools = FirebaseFirestore.instance.collection(
    "schools",
  );
  List<Schoolmodel> schoolinfo = [];

  @override
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: schools.snapshots(),
      builder: (context, snapshot) {
        // 1. Check if we have data yet
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Clear the list to prevent duplicates on rebuilds
        schoolinfo.clear();

        // 3. Fill the list now that we know data exists
        for (var doc in snapshot.data!.docs) {
          schoolinfo.add(Schoolmodel.fromJson(doc));
        }

        if (schoolinfo.isEmpty) {
          return const Center(child: Text("No schools found in database"));
        }

        return ListView(
          children: [Text("First School Lat: ${schoolinfo[0].latitude}")],
        );
      },
    );
  }
}
