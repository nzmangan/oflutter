import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Lib/Shared.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

class EventInformationScreen extends StatefulWidget {
  final EventInformation event;

  EventInformationScreen({
    @required this.event,
  });

  @override
  EventInformationScreenState createState() {
    return new EventInformationScreenState();
  }
}

class EventInformationScreenState extends State<EventInformationScreen> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  @override
  initState() {
    super.initState();
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.event == null) {
      return Container();
    }

    List<Widget> cards = [];

    addStringCard(cards, 'Closing date', widget.event.closingDate);
    addStringCard(cards, 'Club', widget.event.club);
    addStringCard(cards, 'Contact Name', widget.event.contactName);
    addDateCard(cards, 'Date', widget.event.date, 'dd of MMM');
    addStringCard(cards, 'Description', widget.event.description);
    addStringCard(cards, 'Email', widget.event.email);
    addStringCard(cards, 'Event Level', widget.event.eventLevel);
    if (Shared.parseStringToDouble(widget.event.latitude) != null) {
      addStringCard(cards, 'Latitude', widget.event.latitude);
    }
    if (Shared.parseStringToDouble(widget.event.longitude) != null) {
      addStringCard(cards, 'Longitude', widget.event.longitude);
    }
    addStringCard(cards, 'Map', widget.event.map);
    addStringCard(cards, 'Phone', widget.event.phone);
    addStringCard(cards, 'Physical Address', widget.event.physicalAddress);
    addStringCard(cards, 'Pre-Entry', widget.event.preEntry);
    addStringCard(cards, 'Region', widget.event.region);
    addStringCard(cards, 'Signposted From', widget.event.signpostedFrom);
    addStringCard(cards, 'StartTime', widget.event.startTime);
    addStringCard(cards, 'SPORTident', widget.event.timingSystemSPORTident);
    addDateCard(cards, 'Updated', widget.event.updated, 'dd of MMM HH:mm:s');
    addStringCard(cards, 'Url', widget.event.url);
    addStringCard(cards, 'Website', widget.event.website);

    return Column(
      children: cards,
    );
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
}
