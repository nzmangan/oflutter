import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';

class EventInformationMapper {
  static List<EventInformation> fromJsonToList(String contents) {
    return (json.decode(contents) as List)
        .map((e) => eventInformationFromJson(e))
        .toList()
        .cast<EventInformation>();
  }

  static String toJsonFromList(List<EventInformation> events) {
    var map = events.map((f) => eventInformationToJson(f)).toList();
    return json.encode(map);
  }

  static String getStringValue(Map<String, dynamic> json, key) {
    var value = json[key] as String;

    value = (value ?? '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('â', '-')
        .replaceAll('-Â', '-')
        .replaceAll('â', '\'')
        .replaceAll('Â', '');

    return value;
  }

  static DateTime createDate(Map<String, dynamic> json, key) {
    if (json[key] == null) {
      return DateTime.now();
    }

    var dateString = json[key] as String;

    try {
      return DateTime.parse(dateString);
    } catch (ex) {
      DI.getLogger('EventInformationMapper').log(Level.INFO, ex);
    }

    return DateTime.now();
  }

  static EventInformation eventInformationFromJson(Map<String, dynamic> json) {
    var ei = EventInformation()
      ..date = createDate(json, 'date')
      ..updated = createDate(json, 'updated')
      ..country = json['country'] as String
      ..latitude = json['latitude'] as String
      ..longitude = json['longitude'] as String
      ..description = getStringValue(json, 'description')
      ..title = getStringValue(json, 'title')
      ..eventLevel = json['eventLevel'] as String
      ..club = json['club'] as String
      ..physicalAddress = json['physicalAddress'] as String
      ..startTime = json['startTime'] as String
      ..map = json['map'] as String
      ..key = json['key'] as String
      ..email = json['email'] as String
      ..website = json['website'] as String
      ..contactName = json['contactName'] as String
      ..signpostedFrom = json['signpostedFrom'] as String
      ..preEntry = json['preEntry'] as String
      ..closingDate = json['closingDate'] as String
      ..url = json['url'] as String
      ..timingSystemSPORTident = json['timingSystemSPORTident'] as String
      ..phone = json['phone'] as String
      ..location = json['location'] as String
      ..region = json['region'] as String;
    //..eventType =
    //    (json['eventType'] as List)?.map((e) => e as String)?.toList();

    return ei;
  }

  static Map<String, dynamic> eventInformationToJson(
          EventInformation instance) =>
      <String, dynamic>{
        'date': instance.date?.toIso8601String(),
        'updated': instance.updated?.toIso8601String(),
        'country': instance.country,
        'latitude': instance.latitude,
        'longitude': instance.longitude,
        'description': instance.description,
        'title': instance.title,
        'eventLevel': instance.eventLevel,
        'club': instance.club,
        'physicalAddress': instance.physicalAddress,
        'startTime': instance.startTime,
        'map': instance.map,
        'key': instance.key,
        'email': instance.email,
        'website': instance.website,
        'contactName': instance.contactName,
        'signpostedFrom': instance.signpostedFrom,
        'preEntry': instance.preEntry,
        'closingDate': instance.closingDate,
        'url': instance.url,
        'timingSystemSPORTident': instance.timingSystemSPORTident,
        'phone': instance.phone,
        'location': instance.location,
        'region': instance.region,
        //'eventType': instance.eventType
      };
}
