import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Mappers/EventInformationMapper.dart';
import 'package:woc_events_mobile/Models/EventsInformation.dart';

class EventService {
  var _dataService = DI.getDataService();
  var _settingService = DI.getSettingService();
  var _fileService = DI.getFileService();

  Future<EventsInformation> events() async {
    var url = await _settingService.urlEvents();
    return await _dataService.get(
      url + '/api/events',
      EventInformationMapper.fromJson,
    );
  }

  Future<EventsInformation> readEvents() async {
    try {
      String contents = await _fileService.readFile('events.json');
      return EventInformationMapper.fromJson(contents);
    } catch (e) {
      return null;
    }
  }

  Future saveEvents(EventsInformation events) async {
    var json = EventInformationMapper.toJsonFromList(events);
    await _fileService.writeFile('events.json', json);
  }
}
