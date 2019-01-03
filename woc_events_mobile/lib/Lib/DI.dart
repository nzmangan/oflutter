import 'package:logging/logging.dart';
import 'package:woc_events_mobile/Services/ConnectivityService.dart';
import 'package:woc_events_mobile/Services/DataService.dart';
import 'package:woc_events_mobile/Services/EventImageService.dart';
import 'package:woc_events_mobile/Services/EventService.dart';
import 'package:woc_events_mobile/Services/FileService.dart';
import 'package:woc_events_mobile/Services/LocationService.dart';
import 'package:woc_events_mobile/Services/SettingService.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

class DI {
  static Logger getLogger(String name) {
    return new Logger(name);
  }

  static DataService getDataService() {
    return new DataService();
  }

  static SettingService getSettingService() {
    return new SettingService();
  }

  static EventService getEventService() {
    return new EventService();
  }

  static EventImageService getEventImageService() {
    return new EventImageService();
  }

  static FileService getFileService() {
    return new FileService();
  }

  static ThemeService getThemeService() {
    return new ThemeService();
  }

  static LocationService getLocationService() {
    return new LocationService();
  }

  static getConnectivityService() {
    return new ConnectivityService();
  }
}
