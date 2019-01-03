import 'dart:core';
import 'package:woc_events_mobile/Models/EventInformation.dart';

class EventsInformation {
  DateTime lastEventUpdate;
  DateTime lastSync;
  List<EventInformation> events;

  EventsInformation();
}
