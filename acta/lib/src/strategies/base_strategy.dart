import '../event.dart';
import '../loggers/console_logger.dart';

sealed class Strategy {
  void handle(Event event);
}

class ConsoleStrategy implements Strategy {
  final ConsoleLogger logger = ConsoleLogger();

  @override
  void handle(Event event) {
    logger.log(event);
  }
}
