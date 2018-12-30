import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';

class AppHeader extends StatefulWidget {
  final String text;
  final bool showWarning;

  AppHeader({
    @required this.text,
    @required this.showWarning,
  });

  @override
  AppHeaderState createState() {
    return new AppHeaderState();
  }
}

class AppHeaderState extends State<AppHeader> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  AppHeaderState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    var leading = widget.showWarning
        ? Builder(
            builder: (context) => IconButton(
                  icon: Icon(FontAwesomeIcons.exclamationTriangle),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          )
        : null;

    return new SliverAppBar(
      leading: leading,
      elevation: 1,
      forceElevated: true,
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0, 1],
            colors: [
              _theme.appHeaderBackgroundGradientStart,
              _theme.appHeaderBackgroundGradientEnd,
            ],
          ),
        ),
        child: new FlexibleSpaceBar(
          centerTitle: true,
          collapseMode: CollapseMode.pin,
          title: FractionallySizedBox(
            widthFactor: 2 / 3,
            child: Container(
              child: Text(
                widget.text,
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: _theme.appHeaderFontColor,
                  fontFamily: _theme.appHeaderFont,
                  fontWeight: _theme.appHeaderFontWeight,
                  fontSize: _theme.appHeaderFontSize,
                ),
                maxLines: 10,
                overflow: TextOverflow.fade,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
