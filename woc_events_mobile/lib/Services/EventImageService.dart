import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Mappers/EventImageMapper.dart';
import 'package:woc_events_mobile/Models/EventImage.dart';

class EventImageService {
  var _dataService = DI.getDataService();
  var _settingService = DI.getSettingService();
  var _fileService = DI.getFileService();

  Future<List<EventImage>> loadFromInternet(String key) async {
    var url = await _settingService.urlEvents();
    return await _dataService.getList(
      url + '/api/event/' + key + "/images",
      EventImageMapper.fromJson,
    );
  }

  Future<List<EventImage>> loadFromDisk(String key) async {
    try {
      String contents = await _fileService.readFile('events$key.json');
      return EventImageMapper.fromJson(contents);
    } catch (e) {
      return null;
    }
  }

  Future saveToDisk(String key, List<EventImage> images) async {
    await _fileService.writeFile('events$key.json', EventImageMapper.toJson(images));
  }
}
