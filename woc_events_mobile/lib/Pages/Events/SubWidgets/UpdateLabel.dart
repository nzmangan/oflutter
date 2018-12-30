import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

class UpdateLabel extends StatefulWidget {
  final String date;

  UpdateLabel({
    @required this.date,
  });

  @override
  UpdateLabelState createState() {
    return new UpdateLabelState();
  }
}

class UpdateLabelState extends State<UpdateLabel> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  UpdateLabelState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Text(
        widget.date,
        style: TextStyle(
          color: _theme.eventListingUpdatedLabelFontColor,
          fontSize: _theme.eventListingUpdatedLabelFontSize,
          fontFamily: _theme.eventListingUpdatedLabelFont,
          fontWeight: _theme.eventListingUpdatedLabelFontWeight,
        ),
      ),
    );
  }
}
