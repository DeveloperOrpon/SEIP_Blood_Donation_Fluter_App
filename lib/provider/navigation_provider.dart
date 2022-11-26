import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  bool _bool = true;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool get showDrawer => _bool;
  set showDrawer(bool index) {
    _bool = index;
    notifyListeners();
  }

}
