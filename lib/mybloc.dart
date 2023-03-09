import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {

  @override
  void onChange(BlocBase bloc, Change change) {
    print("onChange");
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    print("onCreate");
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print("onClose");
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("onError");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print("onEvent");
    super.onEvent(bloc, event);
  }
}