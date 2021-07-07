import 'package:flutter/material.dart';

Size getMediaQuerySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double getMainAxisHeight(BuildContext context) {
  Size screenSize = getMediaQuerySize(context);
  double mainAxisHeight = screenSize.height > screenSize.width
      ? screenSize.height
      : screenSize.width;
  return mainAxisHeight;
}

ThemeData getThemeDataOfContext(BuildContext context) {
  return Theme.of(context);
}
