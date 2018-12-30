import 'package:queries/collections.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';

class EventsFilter {
  Collection<String> _clubs = new Collection([]);
  List<String> _allClubs = [];

  void setAllCubs(List<String> allClubs) {
    _allClubs = allClubs;
  }

  List<String> getAllClubs() {
    return _allClubs;
  }

  List<String> getSelectedClubs() {
    return _clubs.toList();
  }

  void addClub(String club) {
    _clubs = _clubs.append(club).distinct().orderBy((p) => p).toCollection();
  }

  void removeClub(String club) {
    _clubs = _clubs.where((p) => p != club).distinct().orderBy((p) => p).toCollection();
  }

  bool isSelected(String club) {
    return _clubs.any((p) => p == club);
  }

  List<EventInformation> filter(List<EventInformation> events) {
    return new Collection(events).where((p) {
      return _clubs == null || _clubs.length < 1 || _clubs.any((e) => e == p.club);
    }).toList();
  }
}
