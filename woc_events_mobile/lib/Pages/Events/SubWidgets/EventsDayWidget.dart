import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Pages/Event/EventScreen.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

class EventsDayWidget extends StatefulWidget {
  final List<EventInformation> events;

  EventsDayWidget({
    @required this.events,
  });

  @override
  EventsDayWidgetState createState() {
    return new EventsDayWidgetState();
  }
}

class EventsDayWidgetState extends State<EventsDayWidget> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  EventsDayWidgetState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> events = [];

    var ds = widget.events;
    for (int i = 0; i < ds.length; i++) {
      events.add(_renderEventInfo(ds[i], i));

      if (i != ds.length - 1) {
        events.add(
          Padding(
            padding: EdgeInsets.all(20),
            child: Divider(
              color: _theme.eventListingEventDividerColor,
            ),
          ),
        );
      }
    }

    return Center(
      widthFactor: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: events,
      ),
    );
  }

  _renderEventInfo(EventInformation item, int index) {
    return InkWell(
      splashColor: Colors.red,
      onTap: () {
        _navigate(item);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 5.0,
              color: _theme.eventListingEventColors[index % _theme.eventListingEventColors.length],
            ),
          ),
        ),
        //padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: _theme.eventListingEventTitleFontSize,
                    color: _theme.eventListingEventTitleFontColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  item.map,
                  style: TextStyle(
                    fontFamily: _theme.eventListingEventMapFont,
                    fontWeight: _theme.eventListingEventMapFontWeight,
                    color: _theme.eventListingEventMapFontColor,
                    fontSize: _theme.eventListingEventMapFontSize,
                  ),
                ),
              ),
              Text(
                item.club ?? '',
                style: TextStyle(
                  fontFamily: _theme.eventListingEventClubFont,
                  fontWeight: _theme.eventListingEventClubFontWeight,
                  color: _theme.eventListingEventColors[index % _theme.eventListingEventColors.length],
                  fontSize: _theme.eventListingEventClubFontSize,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(EventInformation item) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (c) {
      return new EventScreen(event: item);
    }));
  }
}
