import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_item_model.freezed.dart';

@freezed
abstract class DashboardItem with _$DashboardItem {
  const factory DashboardItem({
    required String title,
    required String subtitle,
    required String assetImagePath,
    required int bgColorValue, // Store as int for serializability if needed
    required String route, // Path to navigate to
  }) = _DashboardItem;

  const DashboardItem._();

  Color get bgColor => Color(bgColorValue);
}
