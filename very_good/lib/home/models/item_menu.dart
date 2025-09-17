import 'package:flutter/material.dart';

class ItemMenu {
  ItemMenu({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });
  final String title;
  final IconData icon;
  final String route;
  final Color color;
}
