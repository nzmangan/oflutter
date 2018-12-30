import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Models/EventsFilter.dart';
import 'package:woc_events_mobile/Pages/Events/EventsScreen.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/FilterSelect.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';
import 'package:woc_events_mobile/Widgets/AppBackgroundDecoration.dart';

class AppMenuDrawer extends StatefulWidget {
  final bool showWarning;
  final EventsFilter eventsFilter;
  final OnFilterCallback onFilter;

  AppMenuDrawer({
    @required this.showWarning,
    @required this.eventsFilter,
    @required this.onFilter,
  });

  @override
  AppMenuDrawerState createState() {
    return new AppMenuDrawerState();
  }
}

class AppMenuDrawerState extends State<AppMenuDrawer> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  AppMenuDrawerState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (widget.showWarning) {
      children.add(
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
          padding: EdgeInsets.fromLTRB(25, 40, 10, 15),
          decoration: BoxDecoration(
            color: _theme.drawerWarningBackgroundColor,
          ),
          child: Row(
            children: [
              new Icon(
                FontAwesomeIcons.exclamationTriangle,
                color: _theme.drawerWarningTriangleColor,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    'Failed to load events... The list presented may or may not be up to date.',
                    style: TextStyle(
                      color: _theme.drawerFontColor,
                      fontFamily: _theme.drawerFont,
                      fontSize: _theme.drawerFontSize,
                      fontWeight: _theme.drawerFontWeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    children.add(
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        padding: EdgeInsets.fromLTRB(25, widget.showWarning ? 15 : 40, 10, 15),
        decoration: BoxDecoration(color: _theme.drawerHighlightBackgroundColor),
        child: Text(
          'Filter by club',
          style: TextStyle(
            color: _theme.drawerFontColor,
            fontFamily: _theme.drawerFont,
            fontSize: _theme.drawerFontSize,
            fontWeight: _theme.drawerFontWeight,
          ),
        ),
      ),
    );

    children.add(
      Expanded(
        child: FilterSelect(
          eventsFilter: widget.eventsFilter,
          onFilter: widget.onFilter,
        ),
      ),
    );

    children.add(
      Container(
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          padding: EdgeInsets.all(0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
            padding: EdgeInsets.fromLTRB(25, 15, 10, 15),
            decoration: BoxDecoration(color: _theme.drawerHighlightBackgroundColor),
            child: Text(
              'Reload',
              style: TextStyle(
                color: _theme.drawerFontColor,
                fontFamily: _theme.drawerFont,
                fontSize: _theme.drawerFontSize,
                fontWeight: _theme.drawerFontWeight,
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (c) {
              return new EventsScreen();
            }));
          },
        ),
      ),
    );

    return Container(
      decoration: AppBackgroundDecoration(_theme),
      child: Column(
        children: children,
      ),
    );
  }
}
