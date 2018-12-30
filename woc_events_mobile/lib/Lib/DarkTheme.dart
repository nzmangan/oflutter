import 'package:flutter/material.dart';
import 'package:woc_events_mobile/Lib/AppTheme.dart';

class DarkTheme extends AppTheme {
  static const themeMainTextColor = Colors.white;
  static const double themeMainFontSize = 20;
  static const String themeFont = "Avenir";
  static const String themeFontSupplimentary = "avenir-next-thin";
  static const FontWeight themeMainSupplimentaryFontWeight = FontWeight.w300;

  // Global
  Color mainTextColor = themeMainTextColor;
  FontWeight mainSupplimentaryFontWeight = themeMainSupplimentaryFontWeight;
  double mainFontSize = themeMainFontSize;
  Color mainLinkFontColor = Colors.blueAccent;

  //Fonts
  String fontSupplimentary = themeFontSupplimentary;
  String fontMain = themeFont;

  // App
  Color appBackgroundGradientStart = Color.fromARGB(255, 52, 66, 108);
  Color appBackgroundGradientEnd = Color.fromARGB(255, 101, 83, 140);

  // App Header
  Color appHeaderBackgroundGradientStart = Color.fromARGB(255, 88, 100, 134);
  Color appHeaderBackgroundGradientEnd = Color.fromARGB(255, 101, 83, 140);
  Color appHeaderFontColor = themeMainTextColor;
  double appHeaderFontSize = themeMainFontSize;
  String appHeaderFont = themeFontSupplimentary;
  FontWeight appHeaderFontWeight = themeMainSupplimentaryFontWeight;

  // Pagination
  Color paginationDotColor = Color.fromARGB(255, 153, 183, 255);

  // Loader
  Color loaderColor = Colors.white;

  // Drawer
  Color drawerFontColor = themeMainTextColor;
  double drawerFontSize = themeMainFontSize;
  String drawerFont = themeFontSupplimentary;
  FontWeight drawerFontWeight = themeMainSupplimentaryFontWeight;
  Color drawerHighlightBackgroundColor = Color.fromARGB(10, 255, 255, 255);
  Color drawerWarningBackgroundColor = Color.fromARGB(255, 211, 167, 208);
  Color drawerWarningTriangleColor = Colors.white;

  // Filter Select
  Color filterSelectFontColor = themeMainTextColor;
  double filterSelectFontSize = 18;
  Color filterSelectUnselectedHeartColor = Colors.white;
  List<Color> filterSelectBackgroundColors = [
    Color.fromARGB(255, 170, 212, 245),
    Color.fromARGB(255, 170, 255, 245),
    Color.fromARGB(255, 250, 212, 245),
    Color.fromARGB(255, 211, 167, 208),
  ];

  // Event Listing Date
  Color eventListingDateColor = themeMainTextColor;
  double eventListingDateSize = themeMainFontSize;
  String eventListingDateFont = themeFontSupplimentary;
  FontWeight eventListingDateWeight = themeMainSupplimentaryFontWeight;
  Color eventListingDateSelectedTextColor = Colors.black;
  Color eventListingDateSelectedBackGround = Color.fromARGB(255, 170, 212, 245);
  Color eventListingDateUnselectedBackGround = Color.fromARGB(10, 255, 255, 255);

  // Event Listing Event
  Color eventListingEventTitleFontColor = themeMainTextColor;
  double eventListingEventTitleFontSize = themeMainFontSize;

  String eventListingEventMapFont = themeFontSupplimentary;
  FontWeight eventListingEventMapFontWeight = themeMainSupplimentaryFontWeight;
  Color eventListingEventMapFontColor = themeMainTextColor;
  double eventListingEventMapFontSize = themeMainFontSize;

  double eventListingEventClubFontSize = themeMainFontSize;
  String eventListingEventClubFont = themeFontSupplimentary;
  FontWeight eventListingEventClubFontWeight = themeMainSupplimentaryFontWeight;
  Color eventListingEventDividerColor = Colors.white;
  List<Color> eventListingEventColors = [
    Color.fromARGB(255, 170, 212, 245),
    Color.fromARGB(255, 170, 255, 245),
    Color.fromARGB(255, 250, 212, 245),
    Color.fromARGB(255, 211, 167, 208),
  ];

  // Event Listing Updated Label
  Color eventListingUpdatedLabelFontColor = themeMainTextColor;
  double eventListingUpdatedLabelFontSize = 16;
  String eventListingUpdatedLabelFont = themeFontSupplimentary;
  FontWeight eventListingUpdatedLabelFontWeight = themeMainSupplimentaryFontWeight;

  // Chip
  Color chipFontColor = Color.fromARGB(255, 101, 83, 140);
  double chipFontSize = 15;
  Color chipBackgroundColor = Colors.white;

  // Event details
  Color eventDetailsLabelFontColor = Colors.white;
  double eventDetailsLabelFontSize = 15;

  String eventDetailsDetailsFontFamily = themeFontSupplimentary;
  double eventDetailsDetailsFontSize = 18;
  Color eventDetailsDetailsFontColor = Colors.white;
}
