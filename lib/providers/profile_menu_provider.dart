import 'package:flutter/material.dart';

class ProfileMenuProvider extends ChangeNotifier {
  bool _isProfileMenuOpen = false;
  bool get isProfileMenuOpen => _isProfileMenuOpen;

  void openMenu() {
    _isProfileMenuOpen = true;
    notifyListeners();
  }

  void closeMenu() {
    _isProfileMenuOpen = false;
    notifyListeners();
  }
}