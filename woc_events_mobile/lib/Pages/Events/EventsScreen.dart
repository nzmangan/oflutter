import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:queries/collections.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Lib/Shared.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Models/EventsFilter.dart';
import 'package:woc_events_mobile/Models/EventsInformation.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/AppMenuDrawer.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/EventsPage.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/FilterTagsWidget.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/LoadingWidget.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/PageIndicatorWidget.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/UpdateLabel.dart';
import 'package:woc_events_mobile/Services/EventService.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';
import 'package:woc_events_mobile/Widgets/AppBackgroundDecoration.dart';

class EventsScreen extends StatefulWidget {
  @override
  EventsScreenState createState() {
    return new EventsScreenState();
  }
}

class EventsScreenState extends State<EventsScreen> {
  static bool _showWarning = false;

  final EventService eventService = DI.getEventService();
  List<EventInformation> _allEvents;
  final List<EventInformation> _events = [];
  final controller = new PageController(
    initialPage: 0,
  );
  String _updated = "";
  EventsFilter eventsFilter = new EventsFilter();
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;
  bool firstView = true;

  EventsScreenState() {
    _theme = _themeService.getTheme();
  }

  @override
  initState() {
    super.initState();
    loadEvents();
  }

  void setEvents(EventsInformation events, String prefix) {
    _allEvents = events.events;
    var clubs = Collection(_allEvents).select((p) => p.club == null || p.club.trim() == '' ? "Other" : p.club).distinct().orderBy((p) => p).toList();
    eventsFilter.setAllCubs(clubs);

    eventService.saveEvents(events);
    var date = events.lastEventUpdate;
    var text = '${date.day}${Shared.getSuffix(date.day)} of ${new DateFormat('MMMM HH:mm').format(DateTime.now())}';
    _updated = prefix + text;
    filterEvents();
  }

  void filterEvents() {
    setState(() {
      _events.clear();
      _events.addAll(eventsFilter.filter(_allEvents));
    });
  }

  Future loadEvents() async {
    var storedEvents = await eventService.readEvents();
    if (storedEvents != null) {
      _showWarning = true;
      setEvents(storedEvents, 'Loaded from cache at ');
    }

    var events = await eventService.events();
    if (events != null) {
      _showWarning = false;
      setEvents(events, 'As of ');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_allEvents == null || _allEvents.length < 1) {
      return LoadingWidget();
    }

    List<EventsPage> children = _buildPages();

    if (firstView) {
      var now = DateTime.now();

      for (int i = 0; i < children.length; i++) {
        if (children[i].groupKey == now.year * 100 + now.month) {
          Future.delayed(Duration(milliseconds: 1), () {
            controller.jumpToPage(i);
          });
        }
      }

      firstView = false;
    }

    return Scaffold(
      body: Container(
        decoration: AppBackgroundDecoration(_theme),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: children,
                controller: controller,
                onPageChanged: (page) => setState(() {}),
              ),
            ),
            FilterTagsWidget(eventsFilter: eventsFilter, state: this),
            PageIndicatorWidget(
              controller: controller,
              count: children.length,
            ),
            UpdateLabel(date: _updated)
          ],
        ),
      ),
      drawer: Drawer(
        child: AppMenuDrawer(
          showWarning: _showWarning,
          eventsFilter: eventsFilter,
          onFilter: () {
            setState(() {
              filterEvents();
            });
          },
        ),
      ),
    );
  }

  List<EventsPage> _buildPages() {
    List<EventsPage> children = [];

    var e = new Collection<EventInformation>(_events);

    var groupedEvents = e.where((p) => p.date != null).orderBy((p) => p.date).groupBy((k) => k.date.year * 100 + k.date.month).toList();

    for (var group in groupedEvents) {
      children.add(
        EventsPage(
          groupKey: group.key,
          events: group.select((p) => p).toList(),
          showWarning: _showWarning,
        ),
      );
    }

    return children;
  }
}
