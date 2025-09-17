import 'package:get/get.dart';
import 'package:get_x/app/modules/code_errors/bindings/code_errros_binding.dart';
import 'package:get_x/app/modules/code_errors/views/code_errors_view.dart';
import 'package:get_x/app/modules/connection_errors/bindings/connection_errros_binding.dart';
import 'package:get_x/app/modules/connection_errors/views/connection_error_screen.dart';
import 'package:get_x/app/modules/db_errors/bindings/db_errros_binding.dart';
import 'package:get_x/app/modules/db_errors/views/db_errors_view.dart';
import 'package:get_x/app/modules/key_errors/bindings/key_errros_binding.dart';
import 'package:get_x/app/modules/key_errors/views/key_errors_view.dart';
import 'package:get_x/app/modules/memory_leak/bindings/memory_leak_binding.dart';
import 'package:get_x/app/modules/memory_leak/views/memory_leak_view.dart';
import 'package:get_x/app/modules/native_error/views/native_error_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CODE_ERROR_SCREEN,
      page: () => const CodeErrorsView(),
      binding: CodeErrorsBinding(),
    ),
    GetPage(
      name: _Paths.KEY_ERROR_SCREEN,
      page: () => const KeyErrorView(),
      binding: KeyErrorsBinding(),
    ),
    GetPage(
      name: _Paths.MEMORY_LEAK_SCREEN,
      page: () => const MemoryLeakView(),
      binding: MemoryLeakBinding(),
    ),
    GetPage(
      name: _Paths.DB_ERRORS_SCREEN,
      page: () => const DbErrorView(),
      binding: DbErrorsBinding(),
    ),
    GetPage(
      name: _Paths.CONNECTION_ERROR_SCREEN,
      page: () => const ConnectionErrorsScreen(),
      binding: ConnectionErrorsBinding(),
    ),
    GetPage(
      name: _Paths.NATIVE_ERROR_SCREEN,
      page: () => const NativeErrorView(),
      binding: ConnectionErrorsBinding(),
    ),
  ];
}
