import 'package:geolocator/geolocator.dart';

class LocalizationState {

  bool isPermissionAllowed;
  bool isLocationServiceEnabled;
  Position currentPosition;

  // Check the app permissions for localization 
  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if ((permission.toString() == "LocationPermission.whileInUse") || (permission.toString() == "LocationPermission.always")) {
      isPermissionAllowed = true;
    } else {
      isPermissionAllowed = false;
    }
  }

  // Check permission & if localization is enabled (else triggers a popup request), and get device position
  Future<void> checkPosition() async {
    await checkPermission();
    isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}