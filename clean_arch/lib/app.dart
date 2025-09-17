import 'package:clean_arch/main.dart';
import 'package:clean_arch/presentation/code_errors/view_models/code_errors_controller.dart';
import 'package:clean_arch/presentation/code_errors/views/code_errors_view.dart';
import 'package:clean_arch/presentation/connection_errors/view_models/connection_errors_view_model.dart';
import 'package:clean_arch/presentation/connection_errors/views/connection_error_screen.dart';
import 'package:clean_arch/presentation/db_errors/view_models/db_errors_view_model.dart';
import 'package:clean_arch/presentation/db_errors/views/db_errors_view.dart';
import 'package:clean_arch/presentation/home/view_models/home_view_model.dart';
import 'package:clean_arch/presentation/home/views/home_view.dart';
import 'package:clean_arch/presentation/key_errors/view_models/key_errors_view_model.dart';
import 'package:clean_arch/presentation/key_errors/views/key_errors_view.dart';
import 'package:clean_arch/presentation/memory_leak/view_models/memory_leak_view_model.dart';
import 'package:clean_arch/presentation/memory_leak/views/memory_leak_view.dart';
import 'package:clean_arch/presentation/native_error/view_models/native_error_view_model.dart';
import 'package:clean_arch/presentation/native_error/views/native_error_view.dart';
import 'package:clean_arch/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          lazy: false,
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<CodeErrorsViewModel>(
          lazy: false,
          create: (_) => CodeErrorsViewModel(),
        ),
        ChangeNotifierProvider<ConnectionErrorsViewModel>(
          lazy: false,
          create: (_) => ConnectionErrorsViewModel(),
        ),
        ChangeNotifierProvider<DbErrorsViewModel>(
          lazy: false,
          create: (_) => DbErrorsViewModel(),
        ),
        ChangeNotifierProvider<KeyErrorsViewModel>(
          lazy: false,
          create: (_) => KeyErrorsViewModel(),
        ),
        ChangeNotifierProvider<MemoryLeakViewModel>(
          lazy: false,
          create: (_) => MemoryLeakViewModel(),
        ),
        ChangeNotifierProvider<NativeErrorViewModel>(
          lazy: false,
          create: (_) => NativeErrorViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => HomeView(viewModel: context.watch()),
          Routes.codeErrorScreen:
              (context) => CodeErrorsView(viewModel: context.watch()),
          Routes.connectionErrorScreen:
              (context) => ConnectionErrorsView(viewModel: context.watch()),
          Routes.keyErrorScreen:
              (context) => KeyErrorView(viewModel: context.watch()),
          Routes.memoryLeakScreen:
              (context) => MemoryLeakView(viewModel: context.watch()),
          Routes.dbErrors: (context) => DbErrorView(viewModel: context.watch()),
          Routes.nativeError:
              (context) => NativeErrorView(viewModel: context.watch()),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}
