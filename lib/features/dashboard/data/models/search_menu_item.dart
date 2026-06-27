import 'package:flutter/material.dart';

class SearchMenuItem {
  final String title;
  final IconData icon;
  final String? route;
  final int? bottomNavIndex;

  const SearchMenuItem({
    required this.title,
    required this.icon,
    this.route,
    this.bottomNavIndex,
  });
}
