import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/data/services/some_service.dart';

int numberListener = 0;

class MemoryLeakState {
  MemoryLeakState({required this.sharedColor});
  final Color sharedColor;

  MemoryLeakState copyWith({Color? sharedColor, int? numberListener}) {
    return MemoryLeakState(
      sharedColor: sharedColor ?? this.sharedColor,
    );
  }
}

class MemoryLeakCubit extends Cubit<MemoryLeakState> {
  MemoryLeakCubit(this.someService)
      : super(MemoryLeakState(sharedColor: Colors.white)) {
    numberListener++;
    subscription = someService.stream.listen((_) {
      final newColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
      emit(state.copyWith(sharedColor: newColor));
    });

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      someService.addData('Auto event at ${DateTime.now()}');
    });
  }
  final SomeService someService;
  final Random _random = Random();
  late StreamSubscription subscription;
  late Timer timer;

  @override
  Future<void> close() {
    subscription.cancel();
    timer.cancel();
    return super.close();
  }
}
