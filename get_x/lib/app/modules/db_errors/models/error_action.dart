import 'package:acta/acta.dart';

class ErrorAction {
  final String title;
  final String description;
  final String tag;
  ErrorAction({
    required this.title,
    required this.description,
    required this.tag,
  });

  void methodCapture() {
    Handler.capture(
      message:
          '$title Apenas um teste de erro com TAG = $tag e desc = $description',
      severity: Severity.info,
      tag: tag,
    );
  }
}
