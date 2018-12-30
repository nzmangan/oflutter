import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Models/EventsFilter.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

typedef OnFilterCallback = void Function();

class FilterSelect extends StatefulWidget {
  final EventsFilter eventsFilter;
  final OnFilterCallback onFilter;

  FilterSelect({
    @required this.eventsFilter,
    @required this.onFilter,
  });

  @override
  FilterSelectState createState() {
    return new FilterSelectState();
  }
}

class FilterSelectState extends State<FilterSelect> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  FilterSelectState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    List<ListTile> listItems = _buildList();

    return ListView(
      padding: EdgeInsets.zero,
      children: listItems,
    );
  }

  List<ListTile> _buildList() {
    List<ListTile> listItems = [];
    List<String> allClubs = widget.eventsFilter.getAllClubs();

    for (var i = 0; i < allClubs.length; i++) {
      bool selected = widget.eventsFilter.isSelected(allClubs[i]);
      listItems.add(
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          leading: Icon(FontAwesomeIcons.heart, color: selected ? _theme.filterSelectBackgroundColors[i % _theme.filterSelectBackgroundColors.length] : _theme.filterSelectUnselectedHeartColor),
          title: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            //color: selected ? _theme.filterSelectBackgroundColors[i % _theme.filterSelectBackgroundColors.length] : Colors.transparent,
            padding: EdgeInsets.fromLTRB(8, 12, 0, 12),
            decoration: BoxDecoration(
              color: selected ? _theme.filterSelectBackgroundColors[i % _theme.filterSelectBackgroundColors.length] : null,
              border: Border(
                right: BorderSide(
                  width: 5.0,
                  color: _theme.filterSelectBackgroundColors[i % _theme.filterSelectBackgroundColors.length],
                ),
              ),
            ),
            child: Text(
              allClubs[i],
              style: TextStyle(
                fontSize: _theme.filterSelectFontSize,
                color: _theme.filterSelectFontColor,
              ),
            ),
          ),
          onTap: () {
            if (widget.eventsFilter.isSelected(allClubs[i])) {
              widget.eventsFilter.removeClub(allClubs[i]);
            } else {
              widget.eventsFilter.addClub(allClubs[i]);
            }

            widget.onFilter();
          },
        ),
      );
    }

    return listItems;
  }
}
