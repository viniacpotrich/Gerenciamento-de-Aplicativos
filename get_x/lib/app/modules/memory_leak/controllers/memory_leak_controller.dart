import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/data/services/some_service.dart';

class MemoryLeakController extends GetxController {
  final ValueNotifier<Color> sharedColor = ValueNotifier(Colors.white);
  final Random _random = Random();
  int numberListener = 0;

  late StreamSubscription subscription;
  late Timer? timer;
  final someService = SomeService(); //TODO ver onde colocar o service depois

  void initState() {
    // Each “leaked” listener updates sharedColor safely
    subscription = someService.stream.listen((_) {
      sharedColor.value = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });

    // Fire every 3s
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      someService.addData('Auto event at ${DateTime.now()}');
    });
    numberListener++;
  }

  void dispose() {
    subscription.cancel();

    //FIX
    // numberListener--;
    // timer?.cancel();
    super.dispose();
  }
}
