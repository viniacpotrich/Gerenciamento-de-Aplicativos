// A simple service that we can listen to
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SomeService {
  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;

  void addData(String data) {
    _controller.add(data);
  }
}

final someService = SomeService();

class MemoryLeakScreen extends StatefulWidget {
  const MemoryLeakScreen({super.key});

  @override
  State<MemoryLeakScreen> createState() => _MemoryLeakScreenState();
}

class _MemoryLeakScreenState extends State<MemoryLeakScreen> {
  static final ValueNotifier<Color> sharedColor = ValueNotifier(Colors.white);
  final Random _random = Random();

  late StreamSubscription subscription;
  late Timer? timer;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    numberListener--;
    subscription.cancel();

    //FIX
    // timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: sharedColor,
      builder: (context, color, _) {
        return Scaffold(
          backgroundColor: color,
          appBar: AppBar(title: const Text('Memory Leak Screen')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Observe a cor mudar a cada 3 segundos',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Ou saia e entre denovo para vazar memoria',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Numero atual de escutas: $numberListener',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

int numberListener = 0;
