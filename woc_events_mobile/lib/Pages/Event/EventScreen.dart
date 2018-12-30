import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Pages/Event/EventScreenState.dart';

class EventScreen extends StatefulWidget {
  final EventInformation event;

  EventScreen({this.event});

  @override
  EventScreenState createState() {
    return new EventScreenState();
  }
}
