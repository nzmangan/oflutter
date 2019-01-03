import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  void openGoogleMaps(LatLng current, LatLng target, TargetPlatform currentPlatform) {
    if (TargetPlatform.android == currentPlatform) {
      String url = "https://www.google.com/maps/dir/?api=1&origin=${current.latitude},${current.longitude}&destination=${target.latitude},${target.longitude}&travelmode=driving";
      final AndroidIntent intent = new AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull(url),
        package: 'com.google.android.apps.maps',
      );
      intent.launch();
    }
  }
}
