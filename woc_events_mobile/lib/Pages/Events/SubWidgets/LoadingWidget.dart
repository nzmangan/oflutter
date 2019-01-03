import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Pages/Events/EventsScreen.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';
import 'package:woc_events_mobile/Widgets/AppBackgroundDecoration.dart';
import 'package:woc_events_mobile/Widgets/AppHeader.dart';
import 'package:woc_events_mobile/Widgets/Loader.dart';

class LoadingWidget extends StatefulWidget {
  @override
  LoadingWidgetState createState() {
    return new LoadingWidgetState();
  }
}

class LoadingWidgetState extends State<LoadingWidget> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  LoadingWidgetState() {
    _theme = _themeService.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppBackgroundDecoration(_theme),
        child: CustomScrollView(
          slivers: [
            AppHeader(
              text: 'Loading events...',
              showWarning: false,
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: new Loader(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FlatButton(
                child: Text('Reload'),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (c) {
                    return new EventsScreen();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
