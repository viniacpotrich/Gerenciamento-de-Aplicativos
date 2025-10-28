import 'package:acta/acta.dart';
import 'package:logger/logger.dart';

class MyLoger {
  late Logger logger;

  static final MyLoger _instance = MyLoger._();
  factory MyLoger() => _instance;
  MyLoger._() {
    logger = Logger(printer: PrettyPrinter());
  }

  void log(String message) {
    logger.i(message);
    //Reportanto junto ao log
    ActaJournal.report(event: BaseEvent(message: message));
  }
}
