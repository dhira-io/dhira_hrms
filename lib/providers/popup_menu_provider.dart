import 'package:flutter/material.dart';

class PopupMenuProvider extends ChangeNotifier {
  bool _isMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen;

  void openMenu() {
    _isMenuOpen = true;
    notifyListeners();
  }

  void closeMenu() {
    _isMenuOpen = false;
    notifyListeners();
  }
}
