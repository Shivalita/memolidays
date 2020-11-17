import 'package:geolocator/geolocator.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetDistance {

  // Get distance from current position to souvenir's position
  String call(Souvenir souvenir, Position position) {
      int distanceNumber;
      String distance;
      double distanceInMeters = Geolocator.distanceBetween(souvenir.latitude, souvenir.longitude, position.latitude, position.longitude);

      if (distanceInMeters >= 1000) {
        distanceNumber = (distanceInMeters/1000).round();
        distance = distanceNumber.toString() + " Km";
      } else {
        distanceNumber = (distanceInMeters).round();
        distance = distanceNumber.toString() + " m"; 
      }

      return distance;
  }

}
