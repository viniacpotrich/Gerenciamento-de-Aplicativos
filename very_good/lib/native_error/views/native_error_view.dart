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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: cubit.callNative,
              child: const Text('Chamar erro de channel'),
            ),
          ],
        ),
      ),
    );
  }
}
