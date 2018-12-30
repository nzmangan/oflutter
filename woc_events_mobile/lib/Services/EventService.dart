import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Mappers/EventInformationMapper.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';

class EventService {
  var _dataService = DI.getDataService();
  var _settingService = DI.getSettingService();
  var _fileService = DI.getFileService();

  Future<List<EventInformation>> events() async {
    var url = await _settingService.urlEvents();
    return await _dataService.getList(
      url,
      EventInformationMapper.fromJsonToList,
    );
  }

  Future<List<EventInformation>> readEvents() async {
    try {
      String contents = await _fileService.readFile('events.json');
      return EventInformationMapper.fromJsonToList(contents);
    } catch (e) {
      return [];
    }
  }

  Future saveEvents(List<EventInformation> events) async {
    await _fileService.writeFile(
        'events.json', EventInformationMapper.toJsonFromList(events));
  }
}
