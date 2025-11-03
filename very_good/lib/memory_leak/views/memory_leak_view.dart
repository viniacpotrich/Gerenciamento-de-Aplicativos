import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/data/services/some_service.dart';
import 'package:very_good/memory_leak/controllers/memory_leak_controller.dart';

class MemoryLeakPage extends StatelessWidget {
  const MemoryLeakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MemoryLeakCubit(SomeService()),
      child: const MemoryLeakView(),
    );
  }
}

class MemoryLeakView extends StatelessWidget {
  const MemoryLeakView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MemoryLeakCubit>().state;
    return Scaffold(
      backgroundColor: cubit.sharedColor,
      appBar: AppBar(title: const Text('Memory Leak Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Observe a cor mudar a cada 3 segundos',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Ou saia e entre denovo para vazar memoria',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            Text(
              'Numero atual de escutas: $numberListener',
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
