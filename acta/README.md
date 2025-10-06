<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Acta
A tool for application management that captures events and errors in a structured and extensible way.

## Features

- Automatic capture of custom events and errors  
- Event severity tracking (info, warning, error, critical)  
- Support for multiple reporters (console, MongoDB, Elasticsearch, local database)  
- Flexible configuration via `HandlerOptions`  
- Easy integration into any Dart or Flutter application

## Getting started

Add `acta` as a dependency in your `pubspec.yaml`:
```yaml
dependencies:
  acta: ^0.0.1
```

## Usage

Basic example of package initialization:
```dart
ActaJournal.initialize(
    reporters: [
      ConsoleReporter(),
    ],
    options: const HandlerOptions(
      catchAsyncErrors: true,
      logFlutterErrors: true,
      logPlatformErrors: true,
      minSeverity: Severity.info,
      maxBreadcrumbs: 50,
    ),
    initialContext: {'appVersion': '1.0.0', 'build': 1, 'env': 'dev'},
    beforeSend: (report) {
      return report;
    },
    appRunner: () => runApp(const MyApp()),
);
```
Basic example of reporting an event:
```dart
ActaJournal.addBreadcrumb('Pressed INFO');
ActaJournal.report(
    event: BaseEvent(
        message: 'User pressed info',
        severity: Severity.info,
        metadata: {'screen': 'home'},
    ),
);
```
## Additional information


