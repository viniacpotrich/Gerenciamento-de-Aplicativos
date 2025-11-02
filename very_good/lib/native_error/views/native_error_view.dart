import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/data/services/native_service.dart';
import 'package:very_good/native_error/view_models/native_error_view_model.dart';

class NativeErrorPage extends StatelessWidget {
  const NativeErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NativeErrorCubit(NativeService()),
      child: Builder(
        builder: (context) =>
            NativeErrorView(cubit: context.watch<NativeErrorCubit>()),
      ),
    );
  }
}

class NativeErrorView extends StatelessWidget {
  const NativeErrorView({required this.cubit, super.key});
  final NativeErrorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Leak Screen')),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              'Chamar Toast Nativo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Mostra um Toast no Android/iOS'),
            trailing: const Icon(Icons.check_circle_outline),
            onTap: () => cubit.callNativeToast('Esse é um Toast Nativo.'),
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
            onTap: cubit.callNative,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ],
      ),
    );
  }
}
