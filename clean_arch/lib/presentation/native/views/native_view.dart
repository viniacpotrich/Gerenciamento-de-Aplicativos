import 'package:clean_arch/presentation/native/view_models/native_view_model.dart';
import 'package:flutter/material.dart';

class NativeView extends StatelessWidget {
  const NativeView({super.key, required this.viewModel});

  final NativeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Leak Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => viewModel.callNative(),
              child: Text('Chamar erro de channel'),
            ),
          ],
        ),
      ),
    );
  }
}
