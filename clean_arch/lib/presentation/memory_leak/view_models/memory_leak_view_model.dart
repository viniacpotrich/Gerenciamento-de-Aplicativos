import 'dart:async';
import 'dart:math';

import 'package:clean_arch/data/services/some_service.dart';
import 'package:flutter/material.dart';

final someService = SomeService(); //TODO ver onde colocar o service depois

class MemoryLeakViewModel extends ChangeNotifier {
  final ValueNotifier<Color> sharedColor = ValueNotifier(Colors.white);
  final Random _random = Random();
  int numberListener = 0;

  late StreamSubscription subscription;
  late Timer? timer;

  void generateNewColor() {
    sharedColor.value = Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  void onInitState() {
    // Each “leaked” listener updates sharedColor safely
    subscription = someService.stream.listen((_) {
      generateNewColor();
    });

    // Fire every 3s
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      someService.addData('Auto event at ${DateTime.now()}');
    });
    numberListener++;
  }

  void onDispose() {
    subscription.cancel();
    //FIX
    // numberListener--;
    // timer?.cancel();
  }
}
