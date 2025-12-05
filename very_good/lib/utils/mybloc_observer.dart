import 'package:acta/acta.dart';
import 'package:bloc/bloc.dart';

class MyblocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    ActaJournal.report(event: BaseEvent(message: '[$bloc] => $event'));
  }
}
