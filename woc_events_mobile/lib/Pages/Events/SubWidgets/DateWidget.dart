import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Lib/Shared.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

class DateWidget extends StatefulWidget {
  final DateTime date;
  final bool nextEvent;

  DateWidget({
    @required this.date,
    @required this.nextEvent,
  });

  @override
  DateWidgetState createState() {
    return new DateWidgetState();
  }
}

class DateWidgetState extends State<DateWidget> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  DateWidgetState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = widget.nextEvent ? _theme.eventListingDateSelectedBackGround : _theme.eventListingDateUnselectedBackGround;
    Color textColor = widget.nextEvent ? _theme.eventListingDateSelectedTextColor : _theme.eventListingDateColor;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      padding: EdgeInsets.fromLTRB(25, 15, 10, 15),
      decoration: BoxDecoration(color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            new DateFormat('EEEE, ').format(widget.date),
            style: TextStyle(
              color: textColor,
              fontSize: _theme.eventListingDateSize,
              fontFamily: _theme.eventListingDateFont,
              fontWeight: _theme.eventListingDateWeight,
            ),
          ),
          Text(
            widget.date.day.toString(),
            style: TextStyle(
              color: textColor,
              fontSize: _theme.eventListingDateSize,
              fontWeight: _theme.eventListingDateWeight,
            ),
          ),
          Text(
            Shared.getSuffix(widget.date.day),
            style: TextStyle(
              color: textColor,
              fontSize: _theme.eventListingDateSize * 3 / 4,
              fontWeight: _theme.eventListingDateWeight,
            ),
          ),
          Text(
            new DateFormat(' of MMMM').format(widget.date),
            style: TextStyle(
              color: textColor,
              fontSize: _theme.eventListingDateSize,
              fontFamily: _theme.eventListingDateFont,
              fontWeight: _theme.eventListingDateWeight,
            ),
          ),
        ],
      ),
    );
  }
}
