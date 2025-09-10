import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good/db_errors/models/error_action.dart';

class DbErrorsCubit extends Cubit<List<ErrorAction>> {
  DbErrorsCubit()
      : super([
          ErrorAction(
            title: 'Blue Screen Error',
            description: 'Apenas um erro com tag de Blue Screen',
            tag: 'Blue Screen',
          ),
          ErrorAction(
            title: 'Just warning',
            description: 'Nem erro e',
            tag: 'Just warning',
          ),
          ErrorAction(title: 'Virus', description: 'HELP', tag: 'Virus'),
        ]);
}
