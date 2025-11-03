import 'package:clean_arch/presentation/memory_leak/view_models/memory_leak_view_model.dart';
import 'package:flutter/material.dart';

class MemoryLeakView extends StatefulWidget {
  const MemoryLeakView({super.key, required this.viewModel});

  final MemoryLeakViewModel viewModel;

  @override
  State<MemoryLeakView> createState() => _MemoryLeakViewState();
}

class _MemoryLeakViewState extends State<MemoryLeakView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.onInitState();
  }

  @override
  void dispose() {
    widget.viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.sharedColor,
      builder:
          (context, value, child) => Scaffold(
            backgroundColor: value,
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
                    'Numero atual de escutas: ${widget.viewModel.numberListener}',
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
