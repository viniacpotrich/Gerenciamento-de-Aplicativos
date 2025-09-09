import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_x/app/routes/custom_navigator_observer.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // navigatorObservers: [CustomNavigatorObserver()],
    ),
  );
}
