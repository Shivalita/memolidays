import 'package:geolocator/geolocator.dart';

class LocalizationState {

  bool isPermissionAllowed;
  bool isLocationServiceEnabled;
  Position currentPosition;

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // print('permission = $permission');

    if ((permission.toString() == "LocationPermission.whileInUse") || (permission.toString() == "LocationPermission.always")) {
      // print('PERMISSION OK');
      isPermissionAllowed = true;
    } else {
      // print('PERMISSION NOT OK');
      isPermissionAllowed = false;
    }
  }

  Future<void> checkPosition() async {
    await checkPermission();
    isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    // print('isLocationServiceEnabled = $isLocationServiceEnabled');
    currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print('currentPosition = $currentPosition');
  }
}