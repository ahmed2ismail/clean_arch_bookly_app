/*
A simple BlocObserver that logs Bloc lifecycle events to the console.
-- Observer يعني مراقب
هو كلاس بيرث من BlocObserver وبيوفر طريقة سهلة لمراقبة lifecycle events لل Bloc او ال changes في ال Cubit في الابلكيشن

-- طريقة تسجيله في ال main.dart:
void main() {
  // بنسجل ال BlocObserver بتاعنا في ال main.dart في ال void main فوق ال runApp() مباشرة
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
})
*/

import 'package:flutter/material.dart'; // أو import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('Change -- ${bloc.runtimeType} => $change');
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    debugPrint('Transition -- ${bloc.runtimeType} => $transition');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    debugPrint('Close -- ${bloc.runtimeType} => $bloc');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    debugPrint('Create -- ${bloc.runtimeType} => $bloc');
  }

  @override
  void onDone(Bloc<dynamic, dynamic> bloc, Object? event, [Object? error, StackTrace? stackTrace]) {
    super.onDone(bloc, event, error, stackTrace);
    debugPrint('Done -- ${bloc.runtimeType} => $event,/ error: $error,/ stackTrace: $stackTrace');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('Error -- ${bloc.runtimeType} => $error');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('Event -- ${bloc.runtimeType} => $event');
  }
}