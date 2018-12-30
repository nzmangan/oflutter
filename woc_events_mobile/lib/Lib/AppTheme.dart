import 'package:flutter/material.dart';

abstract class AppTheme {
  // Global
  Color mainTextColor;
  FontWeight mainSupplimentaryFontWeight;
  double mainFontSize;
  Color mainLinkFontColor = Colors.blueAccent;

  //Fonts
  String fontSupplimentary;
  String fontMain;

  // App
  Color appBackgroundGradientStart;
  Color appBackgroundGradientEnd;

  // App Header
  Color appHeaderBackgroundGradientStart;
  Color appHeaderBackgroundGradientEnd;
  Color appHeaderFontColor;
  double appHeaderFontSize;
  String appHeaderFont;
  FontWeight appHeaderFontWeight;

  // Pagination
  Color paginationDotColor;

  // Loader
  Color loaderColor;

  // Drawer
  Color drawerFontColor;
  double drawerFontSize;
  String drawerFont;
  FontWeight drawerFontWeight;
  Color drawerHighlightBackgroundColor;
  Color drawerWarningBackgroundColor;
  Color drawerWarningTriangleColor;
  // Filter Select
  Color filterSelectFontColor;
  double filterSelectFontSize;
  Color filterSelectUnselectedHeartColor;
  List<Color> filterSelectBackgroundColors;

  // Event Listing Date
  Color eventListingDateColor;
  double eventListingDateSize;
  String eventListingDateFont;
  FontWeight eventListingDateWeight;
  Color eventListingDateSelectedTextColor;
  Color eventListingDateSelectedBackGround;
  Color eventListingDateUnselectedBackGround;

  // Event Listing Event
  Color eventListingEventTitleFontColor;
  double eventListingEventTitleFontSize;

  String eventListingEventMapFont;
  FontWeight eventListingEventMapFontWeight;
  Color eventListingEventMapFontColor;
  double eventListingEventMapFontSize;

  double eventListingEventClubFontSize;
  String eventListingEventClubFont;
  FontWeight eventListingEventClubFontWeight;
  Color eventListingEventDividerColor;
  List<Color> eventListingEventColors;

  // Event Listing Updated Label
  Color eventListingUpdatedLabelFontColor;
  double eventListingUpdatedLabelFontSize;
  String eventListingUpdatedLabelFont;
  FontWeight eventListingUpdatedLabelFontWeight;

  // Chip
  Color chipFontColor;
  double chipFontSize;
  Color chipBackgroundColor;

  // Event details
  Color eventDetailsLabelFontColor;
  double eventDetailsLabelFontSize;

  String eventDetailsDetailsFontFamily;
  double eventDetailsDetailsFontSize;
  Color eventDetailsDetailsFontColor;
}
