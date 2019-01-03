import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Lib/Shared.dart';
import 'package:woc_events_mobile/Models/EventImage.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Services/ConnectivityService.dart';
import 'package:woc_events_mobile/Services/EventImageService.dart';

class OfflineEventMapWidget extends StatefulWidget {
  final EventInformation event;

  OfflineEventMapWidget({
    @required this.event,
  });

  @override
  OfflineEventMapWidgetState createState() {
    return new OfflineEventMapWidgetState();
  }
}

class OfflineEventMapWidgetState extends State<OfflineEventMapWidget> {
  final ConnectivityService _connectivityService = DI.getConnectivityService();
  final EventImageService _eventImageService = DI.getEventImageService();

  List<EventImage> imgList = [];
  String _connection = 'unknown';
  static const String _offline = 'none';

  @override
  initState() {
    super.initState();
    _getConnectivity();
    _loadImages();
  }

  void _loadImages() async {
    var storedImages = await _eventImageService.loadFromDisk(widget.event.key);
    if (storedImages != null) {
      setState(() {
        imgList = storedImages;
      });
    }

    storedImages = await _eventImageService.loadFromInternet(widget.event.key);
    if (storedImages != null) {
      await _eventImageService.saveToDisk(widget.event.key, storedImages);
      setState(() {
        imgList = storedImages;
      });
    }
  }

  void _getConnectivity() async {
    _connection = await _connectivityService.get();
    setState(() {});
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

    Widget instance = Container();

    if (imgList != null && imgList.length > 0 && _connection != 'unknown') {
      double height = _connection == _offline ? 200 : 0;

      instance = Container(
        height: height,
        child: CarouselSlider(
          items: imgList.map((image) {
            return Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.memory(
                  base64.decode(image.data),
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
              ),
            );
          }).toList(),
          viewportFraction: 0.9,
          aspectRatio: 2 / 1,
          autoPlay: false,
        ),
      );
    }

    return instance;
  }
}
