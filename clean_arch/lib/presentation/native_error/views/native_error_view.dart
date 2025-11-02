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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: const Text(
                'Chamar Toast Nativo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Mostra um Toast no Android/iOS'),
              trailing: const Icon(Icons.check_circle_outline),
              onTap: () => viewModel.callNativeToast('Esse é um Toast Nativo.'),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            ListTile(
              title: const Text(
                'Chamar erro de channel',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Mostra um Erro ao chamar um channel que não existe',
              ),
              trailing: const Icon(Icons.error_outline),
              onTap: () => viewModel.callNativeError(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
