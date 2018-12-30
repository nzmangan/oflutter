import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';

class AppBackgroundDecoration extends BoxDecoration {
  AppBackgroundDecoration(AppTheme theme)
      : super(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0, 1],
            colors: [
              theme.appBackgroundGradientStart,
              theme.appBackgroundGradientEnd,
            ],
          ),
        );
}
