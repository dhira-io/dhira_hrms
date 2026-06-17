import 'package:flutter/material.dart';

class SearchMenuItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final String? route;
  final int? bottomNavIndex;

  const SearchMenuItem({
    required this.title,
    this.subtitle,
    required this.icon,
    this.route,
    this.bottomNavIndex,
  });
}
