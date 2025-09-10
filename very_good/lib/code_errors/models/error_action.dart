import 'package:flutter/material.dart';

class ErrorAction {
  final String title;
  final String description;
  final VoidCallback action;
  ErrorAction({
    required this.title,
    required this.description,
    required this.action,
  });
}
