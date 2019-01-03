import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Pages/Event/SubWidgets/EventInformation.dart';
import 'package:woc_events_mobile/Pages/Event/SubWidgets/EventMapWidget.dart';
import 'package:woc_events_mobile/Pages/Event/SubWidgets/OfflineEventMapWidget.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';
import 'package:woc_events_mobile/Widgets/AppBackgroundDecoration.dart';
import 'package:woc_events_mobile/Widgets/AppHeader.dart';

class EventScreen extends StatefulWidget {
  final EventInformation event;

  EventScreen({this.event});

  @override
  EventScreenState createState() {
    return new EventScreenState();
  }
}

class EventScreenState extends State<EventScreen> {
  EventInformation _event;
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  @override
  initState() {
    super.initState();
    _event = widget.event;
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppBackgroundDecoration(_theme),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  EventMapWidget(
                    event: _event,
                  ),
                  OfflineEventMapWidget(
                    event: _event,
                  ),
                ],
              ),
            ),
            AppHeader(
              text: _event.title,
              showWarning: false,
            ),
            SliverToBoxAdapter(
              child: EventInformationScreen(event: _event),
            ),
          ],
        ),
      ),
    );
  }
}
