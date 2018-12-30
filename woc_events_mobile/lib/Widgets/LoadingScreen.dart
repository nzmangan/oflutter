import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Widgets/AppBackgroundDecoration.dart';
import 'package:woc_events_mobile/Widgets/AppHeader.dart';
import 'package:woc_events_mobile/Widgets/Loader.dart';

class LoadingScreen extends Scaffold {
  LoadingScreen(AppTheme theme)
      : super(
          body: Container(
            decoration: AppBackgroundDecoration(theme),
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
              ],
            ),
          ),
        );
}
