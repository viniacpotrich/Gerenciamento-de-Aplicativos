import 'package:clean_arch/presentation/db_errors/models/error_action.dart';
import 'package:flutter/material.dart';

class DbErrorsViewModel extends ChangeNotifier {
  final List<ErrorAction> actions = [
    ErrorAction(
      title: "Blue Screen Error",
      description: "Apenas um erro com tag de Blue Screen",
      tag: "Blue Screen",
    ),
    ErrorAction(
      title: "Just warning",
      description: "Nem erro e",
      tag: "Just warning",
    ),
    ErrorAction(title: "Virus", description: "HELP", tag: "Virus"),
  ];
}
