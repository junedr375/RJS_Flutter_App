import 'package:flutter/cupertino.dart';

class DrawerNotifier extends ChangeNotifier {
  double _xOffset = 0.0;
  double _yOffset = 0.0;
  double _scale = 1.0;

  bool _isDrawerVisible = false;

  bool get isDrawerVisible => _isDrawerVisible;
  double get xOffset => _xOffset;
  double get yOffset => _yOffset;
  double get scale => _scale;

  void toggleDrawerScreen(BuildContext context) {
    if (isDrawerVisible) {
      _xOffset = 0.0;
      _yOffset = 0.0;
      _scale = 1.0;
      _isDrawerVisible = false;
    } else {
      _xOffset = MediaQuery.of(context).size.width * 0.70;
      _yOffset = 80.0;
      _scale = .8;
      _isDrawerVisible = true;
    }
    notifyListeners();
  }
}
