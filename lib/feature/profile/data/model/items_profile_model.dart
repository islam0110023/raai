import 'package:flutter/material.dart';

class ItemsProfileModel {
  ItemsProfileModel({
    required this.icon,
    required this.title,
    this.index = 0,
    this.onTap,
  });

  final String icon;
  final String title;
  final int index;
  final VoidCallback? onTap;
}
