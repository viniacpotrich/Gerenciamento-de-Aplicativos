import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:projeto_novo/main.dart';
import 'package:projeto_novo/reseter.dart';

void showPopUp(Event? event) {
  final messenger = scaffoldMessengerKey?.currentState;
  if (messenger != null) {
    messenger.showSnackBar(mySnackBar(event));
  }
  Future.delayed(Duration(seconds: 2), () => Reseter.restartApp());
}

SnackBar mySnackBar(Event? event) {
  return SnackBar(
    content: ListTile(
      title: Text(
        'Oops Algum erro ocorreu!',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
