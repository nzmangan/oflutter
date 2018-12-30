import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';
import 'package:woc_events_mobile/Lib/DI.dart';
import 'package:woc_events_mobile/Services/ThemeService.dart';
import 'package:woc_events_mobile/Widgets/DotsIndicator.dart';

class PageIndicatorWidget extends StatefulWidget {
  final int count;
  final PageController controller;

  PageIndicatorWidget({
    @required this.count,
    @required this.controller,
  });

  @override
  PageIndicatorWidgetState createState() {
    return new PageIndicatorWidgetState();
  }
}

class PageIndicatorWidgetState extends State<PageIndicatorWidget> {
  ThemeService _themeService = DI.getThemeService();
  AppTheme _theme;

  PageIndicatorWidgetState() {
    _theme = _themeService.getTheme();
  }

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                DotsIndicator(
                  controller: widget.controller,
                  itemCount: widget.count,
                  onPageSelected: (int page) {
                    widget.controller.animateToPage(
                      page,
                      duration: _kDuration,
                      curve: _kCurve,
                    );
                  },
                  color: _theme.paginationDotColor,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        )
      ],
    );
  }
}
