import 'dart:convert';
import 'package:woc_events_mobile/Models/EventImage.dart';

class EventImageMapper {
  static List<EventImage> fromJson(String contents) {
    return (json.decode(contents) as List).map((e) => eventImageFromJson(e)).toList().cast<EventImage>();
  }

  static EventImage eventImageFromJson(Map<String, dynamic> json) {
    var ei = EventImage()
      ..data = json['data'] as String
      ..name = json['name'] as String
      ..title = json['title'] as String;

    return ei;
  }

  static String toJson(List<EventImage> images) {
    return json.encode(images.map((f) => eventImageToJson(f)).toList());
  }

  static Map<String, dynamic> eventImageToJson(EventImage instance) => <String, dynamic>{
        'data': instance.data,
        'name': instance.name,
        'title': instance.title,
      };
}
