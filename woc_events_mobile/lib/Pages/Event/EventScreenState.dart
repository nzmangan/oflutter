import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Pages/Event/EventScreen.dart';
import 'package:woc_events_mobile/Pages/Event/SubWidgets/EventMapWidget.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';
import 'package:woc_events_mobile/Widgets/AppBackgroundDecoration.dart';
import 'package:woc_events_mobile/Widgets/AppHeader.dart';

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
    List<Widget> widgets = [];

    var mapWidget = EventMapWidget(
      event: _event,
    );

    if (mapWidget != null) {
      widgets.add(
        SliverToBoxAdapter(
          child: mapWidget,
        ),
      );
    }

    widgets.add(
      AppHeader(
        text: _event.title,
        showWarning: false,
      ),
    );

    List<Widget> cards = buildInformationWidgets();

    widgets.add(
      SliverToBoxAdapter(
        child: Column(
          children: cards,
        ),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: AppBackgroundDecoration(_theme),
        child: CustomScrollView(
          slivers: widgets,
        ),
      ),
    );
  }

  void addStringCard(List<Widget> cards, String label, String value) {
    if (value != null && value != '') {
      cards.add(_addStringValue(label, value));
    }
  }

  void addDateCard(List<Widget> cards, String label, DateTime value, String format) {
    if (value != null) {
      var formatter = new DateFormat(format);
      cards.add(_addStringValue(label, formatter.format(value)));
    }
  }

  Widget _addStringValue<T>(String label, String value) {
    Widget child;

    if (value != null && (value.startsWith('http') || value.startsWith('www'))) {
      if (value.startsWith('www')) {
        value = "http://" + value;
      }

      child = InkWell(
        onTap: () async {
          if (await canLaunch(value)) {
            await launch(value);
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  value ?? '',
                  style: TextStyle(
                    fontFamily: _theme.eventDetailsDetailsFontFamily,
                    fontSize: _theme.eventDetailsDetailsFontSize,
                    color: _theme.eventDetailsDetailsFontColor,
                  ),
                ),
              ),
            ),
            Icon(
              FontAwesomeIcons.link,
              color: Colors.white,
            ),
          ],
        ),
      );
    } else {
      child = Text(
        value ?? '',
        style: TextStyle(
          fontFamily: _theme.eventDetailsDetailsFontFamily,
          fontSize: _theme.eventDetailsDetailsFontSize,
          color: _theme.eventDetailsDetailsFontColor,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: _theme.eventDetailsLabelFontColor,
                fontSize: _theme.eventDetailsLabelFontSize,
              ),
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }

  List<Widget> buildInformationWidgets() {
    if (_event == null) {
      return [];
    }

    List<Widget> cards = [];

    addStringCard(cards, 'Closing date', _event.closingDate);
    addStringCard(cards, 'Club', _event.club);
    addStringCard(cards, 'Contact Name', _event.contactName);
    addDateCard(cards, 'Date', _event.date, 'dd of MMM');
    addStringCard(cards, 'Description', _event.description);
    addStringCard(cards, 'Email', _event.email);
    addStringCard(cards, 'Event Level', _event.eventLevel);
    addStringCard(cards, 'Latitude', _event.latitude);
    addStringCard(cards, 'Longitude', _event.longitude);
    addStringCard(cards, 'Map', _event.map);
    addStringCard(cards, 'Phone', _event.phone);
    addStringCard(cards, 'Physical Address', _event.physicalAddress);
    addStringCard(cards, 'Pre-Entry', _event.preEntry);
    addStringCard(cards, 'Region', _event.region);
    addStringCard(cards, 'Signposted From', _event.signpostedFrom);
    addStringCard(cards, 'StartTime', _event.startTime);
    addStringCard(cards, 'SPORTident', _event.timingSystemSPORTident);
    addDateCard(cards, 'Updated', _event.updated, 'dd of MMM HH:mm:s');
    addStringCard(cards, 'Url', _event.url);
    addStringCard(cards, 'Website', _event.website);

    return cards;
  }
}
