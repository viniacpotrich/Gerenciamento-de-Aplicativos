import 'package:flutter/material.dart';
import 'package:projeto_novo/main.dart';

class Reseter extends StatefulWidget {
  Reseter() : super(key: Reseter.local);
  static final local = GlobalKey<_ReseterState>();
  static void restartApp() => local.currentState?.restart();
  @override
  State<Reseter> createState() => _ReseterState();
}

class _ReseterState extends State<Reseter> {
  Key appKey = UniqueKey();
  void restart() => setState(() => appKey = UniqueKey());
  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: appKey, child: const MyApp());
}
