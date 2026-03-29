import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/custombutton.dart';
import 'package:madrasati_plus/helper/custotext.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:geolocator/geolocator.dart';

class LookingForSchool extends StatefulWidget {
  @override
  State<LookingForSchool> createState() => _LookingForSchoolState();
}

class _LookingForSchoolState extends State<LookingForSchool> {
  Position? myposition;
  Future getcurrentlocation() async {
    bool locationserviceenabled;
    LocationPermission permission;
    locationserviceenabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      myposition = await Geolocator.getCurrentPosition();
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: "find schools near me",
          onPressed: () {
            Navigator.pushNamed(
              context,
              "schoolslist",
              arguments: {
                "longitude": myposition!.latitude,
                "latitude": myposition!.longitude,
              },
            );
          },
        ),
      ],
    );
  }

  void initState() {
    super.initState();
    getcurrentlocation();
  }
}
