import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:madrasati_plus/models/schools.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/schoolcard.dart';

class nearschools extends StatelessWidget {
  final double? userLat;
  final double? userLong;

  nearschools({super.key, this.userLat, this.userLong});

late final CollectionReference schools = FirebaseFirestore.instance.collection('schools');

double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double distance = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distance / 1000; // km
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: schools.snapshots(), 
      builder: (BuildContext context, snapshot) {
        return snapshot.hasError
            ? Text("something went wrong")
            : snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : snapshot.hasData
                    ? (() {
                        List<Schoolmodel> schoolslist = snapshot.data!.docs.map((doc) => Schoolmodel.fromJson(doc.data())).toList();
                        if (userLat != null && userLong != null) {
                          schoolslist = schoolslist.where((school) => 
                            _calculateDistance(userLat!, userLong!, school.latitude, school.longitude) < 10
                          ).toList();
                        }
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Schoolslistcard(
                              schoolname: schoolslist[index].title,
                              schoollocation: schoolslist[index].address,
                            );
                          },
                          itemCount: schoolslist.length,
                        );
                      })()
                    : const Text("no nearschools found..try to search for schools in another location");
      },
    );
  }
}
