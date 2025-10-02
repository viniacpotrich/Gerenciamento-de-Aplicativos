import 'package:bloc/bloc.dart';
import 'package:very_good/data/services/native_service.dart';

class NativeErrorCubit extends Cubit<NativeService> {
  NativeErrorCubit(this.nativeService) : super(nativeService);
  final NativeService nativeService;
  void callNative() => NativeService.callNativeError();
  void callNativeToast(String str) => NativeService.callNativeToast(str);
}
