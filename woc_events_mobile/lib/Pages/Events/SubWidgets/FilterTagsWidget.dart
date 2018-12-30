import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Models/EventsFilter.dart';
import 'package:woc_events_mobile/Pages/Events/EventsScreenState.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

class FilterTagsWidget extends StatefulWidget {
  final EventsFilter eventsFilter;
  final EventsScreenState state;

  FilterTagsWidget({
    @required this.eventsFilter,
    @required this.state,
  });

  @override
  FilterTagsWidgetState createState() {
    return new FilterTagsWidgetState();
  }
}

class FilterTagsWidgetState extends State<FilterTagsWidget> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  FilterTagsWidgetState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: Wrap(
        children: _buildCategoryChips(widget.eventsFilter.getSelectedClubs()),
      ),
    );
  }

  List<Widget> _buildCategoryChips(List<String> items) {
    return items.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(category),
          labelStyle: TextStyle(
            color: _theme.chipFontColor,
            fontSize: _theme.chipFontSize,
          ),
          backgroundColor: _theme.chipBackgroundColor,
          onDeleted: () {
            setState(() {
              widget.eventsFilter.removeClub(category);
              widget.state.filterEvents();
            });
          },
        ),
      );
    }).toList();
  }
}
