import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madrasati_plus/helper/custombutton.dart';

class currentlocation extends StatefulWidget {
  currentlocation({super.key});
  @override
  State<currentlocation> createState() => _currentlocationState();
}

class _currentlocationState extends State<currentlocation> {
  getcurrentlocationapp() async {
    bool serviceenabled;
    LocationPermission? permission;

    serviceenabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (serviceenabled == true) {
      print("true");
    } else {
      return ("please turn ur location on");
    }

    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("location permission is denied");
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();

      double? mylat = position.latitude;
      double? mylong = position.longitude;

      double spacebetween = Geolocator.distanceBetween(
        mylat,
        mylong,
        31.96745,
        35.96480,
      );

      print(position!.latitude);
      print(position.longitude);
      print(spacebetween / (1000));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: "show",
          onPressed: () {
            Navigator.pushNamed(context, "schoolslist");
          },
        ),
      ],
    );
  }

  void initState() {
    super.initState();
    getcurrentlocationapp(); // تشغيل الدالة عند فتح الصفحة
  }

  @override
  void dispose() {
    super.dispose();
  }
}
