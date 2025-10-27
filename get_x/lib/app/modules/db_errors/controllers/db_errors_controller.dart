import 'package:get/get.dart';
import 'package:get_x/app/modules/db_errors/models/error_action.dart';

class DbErrorsController extends GetxController {
  final List<ErrorAction> actions = [
    ErrorAction(
      title: "Blue Screen Error",
      description: "Apenas um erro com tag de Blue Screen",
      tag: "Blue Screen",
    ),
    ErrorAction(
      title: "Just warning",
      description: "Apenas um alerta",
      tag: "Just warning",
    ),
    ErrorAction(title: "Error", description: "HELP", tag: "Error"),
  ];
}
