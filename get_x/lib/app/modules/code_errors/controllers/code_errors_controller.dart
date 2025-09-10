import 'package:get/get.dart';
import 'package:get_x/app/modules/code_errors/models/error_action.dart';
import 'package:get_x/utils/code_errors.dart';

class CodeErrorsController extends GetxController {
  final List<ErrorAction> actions = [
    ErrorAction(
      title: "Cast Error",
      description: "int inteiro = 0.0 as int",
      action: methodErrorCast,
    ),
    ErrorAction(
      title: "Divide by Zero",
      description: "10 ~/ 0",
      action: methodDivideByZero,
    ),
    ErrorAction(
      title: "Null Check Error",
      description: "text!.length",
      action: methodNullError,
    ),
    ErrorAction(
      title: "Range Error",
      description: "list[99]",
      action: methodRangeError,
    ),
    ErrorAction(
      title: "Format Error",
      description: "int.parse('not_a_number')",
      action: methodFormatError,
    ),
  ];
}
