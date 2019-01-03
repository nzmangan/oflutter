import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Lib/Shared.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Services/ConnectivityService.dart';
import 'package:woc_events_mobile/Services/LocationService.dart';

class EventMapWidget extends StatefulWidget {
  final EventInformation event;

  EventMapWidget({
    @required this.event,
  });

  @override
  EventMapWidgetState createState() {
    return new EventMapWidgetState();
  }
}

class EventMapWidgetState extends State<EventMapWidget> {
  LocationService _locationService = DI.getLocationService();
  ConnectivityService _connectivityService = DI.getConnectivityService();

  double _zoom = 13;
  double _mapHeight = 1;
  GoogleMapController mapController;
  String _connection = 'unknown';
  static const String _offline = 'none';
  LatLng currentPosition;

  @override
  initState() {
    super.initState();
    _getConnectivity();
    _getLocation();
  }

  _getConnectivity() async {
    _connection = await _connectivityService.get();
    setState(() {});
  }

  _getLocation() async {
    currentPosition = await _locationService.getLocation();
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      if (widget.event != null) {
        var lat = double.parse(widget.event.latitude);
        var lng = double.parse(widget.event.longitude);
        mapController
            .animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(lat, lng),
            14,
          ),
        )
            .whenComplete(() {
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              _mapHeight = 300;
            });
          });
        });

        controller.addMarker(MarkerOptions(
          position: LatLng(
            lat,
            lng,
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.event == null) {
      return Container();
    }

    double lat = Shared.parseStringToDouble(widget.event.latitude);
    double lng = Shared.parseStringToDouble(widget.event.longitude);

    if (lat == null || lng == null || lat == 0 || lng == 0) {
      return Container();
    }

    Widget googleMap = Container();
    Widget directions = Container();
    var platform = Theme.of(context).platform;

    if (currentPosition != null && TargetPlatform.android == platform) {
      directions = FlatButton(
        onPressed: () {
          String origin = '${currentPosition.latitude},${currentPosition.longitude}';
          String destination = '$lat,$lng';

          if (TargetPlatform.android == platform) {
            String url = "https://www.google.com/maps/dir/?api=1&origin=" + origin + "&destination=" + destination + "&travelmode=driving";
            final AndroidIntent intent = new AndroidIntent(
              action: 'action_view',
              data: Uri.encodeFull(url),
              package: 'com.google.android.apps.maps',
            );
            intent.launch();
          }
        },
        child: Icon(FontAwesomeIcons.car, color: Colors.white),
      );
    }

    if (_connection != _offline) {
      googleMap = Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              width: MediaQuery.of(context).size.width,
              height: _mapHeight,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                options: GoogleMapOptions(
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  cameraPosition: CameraPosition(
                    target: LatLng(lat - 0.1, lng - 0.1),
                    zoom: _zoom,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Color.fromARGB(50, 52, 66, 108),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _zoom++;
                    if (_zoom > 16) {
                      _zoom = 16;
                    }
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(
                            lat,
                            lng,
                          ),
                          zoom: _zoom,
                        ),
                      ),
                    );
                  },
                  child: Icon(FontAwesomeIcons.searchPlus, color: Colors.white),
                ),
                FlatButton(
                  onPressed: () {
                    _zoom--;
                    if (_zoom < 10) {
                      _zoom = 10;
                    }
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(
                            lat,
                            lng,
                          ),
                          zoom: _zoom,
                        ),
                      ),
                    );
                  },
                  child: Icon(FontAwesomeIcons.searchMinus, color: Colors.white),
                ),
                directions,
              ],
            ),
          ),
        ],
      );
    }

    return googleMap;
  }
}
