import 'package:clean_arch/presentation/native_error/view_models/native_error_view_model.dart';
import 'package:flutter/material.dart';

class NativeErrorView extends StatelessWidget {
  const NativeErrorView({super.key, required this.viewModel});

  final NativeErrorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native Error Screen')),
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
