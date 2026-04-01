import 'package:geolocator/geolocator.dart';

 class mylocation {
  double mylat=0.0;
  double mylong=0.0;
 getcurrentlocation() async{

bool serviceenabled;
LocationPermission? permission;

serviceenabled =await Geolocator.isLocationServiceEnabled();
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

      mylat = position.latitude;
      mylong = position.longitude;




    }    
    

}
double? getmylat(){
  return mylat;}
  double? getmylong(){
    return mylong;}
}