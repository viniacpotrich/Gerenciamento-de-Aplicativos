import 'package:acta/acta.dart';

class ErrorAction {
  ErrorAction({
    required this.title,
    required this.description,
    required this.tag,
  });
  final String title;
  final String description;
  final String tag;

  void methodCapture() {
    Handler.capture(
      event: Event(
        message:
            '$title Apenas um teste de erro com TAG = $tag e desc = $description',
        severity: Severity.info,
        tag: tag,
      ),
    );
  }
}
