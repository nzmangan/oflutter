import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  Location _location = new Location();

  Future<LatLng> getLocation() async {
    Map<String, double> location;

    try {
      location = await _location.getLocation();
    } on Exception {
      return null;
    }

    var lat = location['latitude'];
    var lng = location['longitude'];

    return LatLng(lat, lng);
  }
}
