import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';

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
  double _mapHeight = 1;
  GoogleMapController mapController;

  double parseString(String input) {
    if (input == null || input.trim() == '') {
      return null;
    }

    double value;

    try {
      value = double.parse(widget.event.latitude);
    } catch (Exception) {
      value = null;
    }

    if (value == 0 || value == 0.000000) {
      return null;
    }

    return value;
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
              _mapHeight = 200;
            });
          });
        });

        controller.addMarker(MarkerOptions(
          position: LatLng(
            lat,
            lng,
          ),
          infoWindowText: InfoWindowText(
            widget.event.title,
            '${widget.event.latitude}, ${widget.event.longitude}',
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

    double lat = parseString(widget.event.latitude);
    double lng = parseString(widget.event.longitude);

    if (lat == null || lng == null) {
      return Container();
    }

    return Center(
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
              zoom: 13,
            ),
          ),
        ),
      ),
    );
  }
}
