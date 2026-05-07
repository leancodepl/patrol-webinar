import 'package:flutter/widgets.dart';

class AppContextMenuController extends ChangeNotifier {
  AppContextMenuController({bool initiallyVisible = false})
    : _visible = initiallyVisible;

  var _visible = false;

  bool get visible => _visible;

  void show() {
    _visible = true;
    notifyListeners();
  }

  void hide() {
    _visible = false;
    notifyListeners();
  }
}
