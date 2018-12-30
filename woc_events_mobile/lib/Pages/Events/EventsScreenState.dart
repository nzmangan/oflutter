import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:queries/collections.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Lib/Shared.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Models/EventsFilter.dart';
import 'package:woc_events_mobile/Pages/Events/EventsScreen.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/AppMenuDrawer.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/EventsPage.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/FilterTagsWidget.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/PageIndicatorWidget.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/UpdateLabel.dart';
import 'package:woc_events_mobile/Services/EventService.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';
import 'package:woc_events_mobile/Widgets/AppBackgroundDecoration.dart';
import 'package:woc_events_mobile/Widgets/LoadingScreen.dart';

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

  EventsScreenState() {
    _theme = _themeService.getTheme();
  }

  @override
  initState() {
    super.initState();
    loadEvents();
  }

  void setEvents(events, prefix) {
    _allEvents = events;
    var clubs = Collection(_allEvents).select((p) => p.club == null || p.club.trim() == '' ? "Other" : p.club).distinct().orderBy((p) => p).toList();
    eventsFilter.setAllCubs(clubs);

    eventService.saveEvents(events);
    var text = DateTime.now().day.toString() + Shared.getSuffix(DateTime.now().day) + " of " + new DateFormat('MMMM HH:mm').format(DateTime.now());
    _updated = prefix + text;
    filterEvents();
  }

  void filterEvents() {
    setState(() {
      _events.clear();
      _events.addAll(eventsFilter.filter(_allEvents));
    });
  }

  void loadEvents() {
    print('Loading...');
    eventService.readEvents().then((storedEvents) {
      if (storedEvents != null) {
        _showWarning = true;
        setEvents(storedEvents, 'Loaded from cache at ');
      }
      eventService.events().then((events) {
        _showWarning = false;
        setEvents(events, 'As of ');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_allEvents == null || _allEvents.length < 1) {
      return LoadingScreen(_theme);
    }

    List<Widget> children = _buildPages();

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

  List<Widget> _buildPages() {
    List<Widget> children = [];

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
