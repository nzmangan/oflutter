import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Pages/Events/EventsScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  var _themeService = DI.getThemeService();
  AppTheme theme;

  MyAppState() {
    theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Wellington OC Events",
      home: new EventsScreen(),
      theme: ThemeData(fontFamily: theme.fontMain),
    );
  }
}
