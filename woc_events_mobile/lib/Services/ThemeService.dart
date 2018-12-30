import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DarkTheme.dart';
//import 'package:woc_events_mobile/Lib/LightTheme.dart';

class ThemeService {
  AppTheme getTheme() {
    return DarkTheme();
    //return LightTheme();
  }
}
