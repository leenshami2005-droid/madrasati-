import 'package:flutter/material.dart';
import 'package:madrasati_plus/const.dart';
import 'package:madrasati_plus/helper/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrasati_plus/helper/custombutton.dart';
import 'package:madrasati_plus/helper/custotext.dart';
import 'package:madrasati_plus/models/students.dart';

import 'package:flutter/material.dart';
import 'package:madrasati_plus/const.dart';
import 'package:madrasati_plus/helper/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  List grids = [
    {"name": "subjects", "image": "assets/imgs/book.png"},
    {"name": "grades", "image": "assets/imgs/marks.jpg"},
  ];

  CollectionReference students = FirebaseFirestore.instance.collection(
    "students",
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: students.snapshots(),
      builder: (context, snapshot) {
        List<Student> studentsinfo = [];

        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          studentsinfo.add(Student.fromJson(snapshot.data!.docs[i]));
        }
        return Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              child: Card(
                color: kprimarycolor,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "student name: ",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "${studentsinfo[0].name}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              "grade: ",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text("${studentsinfo[0].grade}"),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              "section: ",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text("${studentsinfo[0].section}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: grids.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, i) {
                  return customCard(
                    label: grids[i]["image"],
                    name: grids[i]["name"],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
