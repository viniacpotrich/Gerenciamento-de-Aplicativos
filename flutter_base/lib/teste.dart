import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart';

// void main() => runApp(const MyApp());

void main() async {
  ActaJournal.initialize(
    reporters: [ConsoleReporter()], //Reporters
    initialContext: {'app': 'test'}, //Helper info
    onCaptured: showPopup, //Handler do pos evento
    appRunner: () async => runnable(), //chama main pode ser async
  );
}

void runnable() => runApp(const MyApp());

void showPopup(Event? event) {}

void reporterTest() {
  ActaJournal.report(
    event: BaseEvent(message: 'message', severity: Severity.warning),
  );
}

void addInfo() {
  ActaJournal.addBreadcrumb('Info Extra');
}

void addLateInitialContext() {
  ActaJournal.setContextKey('newContext1', 'newContextInfo1');
  ActaJournal.setContext({'newContext2': 'newContextInfo2'});
}
