import 'dart:async';

import 'package:acta/acta.dart';

typedef BeforeSend = FutureOr<Event?> Function(Event event);
typedef OnCaptured = void Function(Event? event);
