import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      log('--- BLoC Change ---');
      log('Bloc: ${bloc.runtimeType}');
      log('Current State: ${change.currentState}');
      log('Next State: ${change.nextState}');
      log('--------------------');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      log('--- BLoC Event ---');
      log('Bloc: ${bloc.runtimeType}');
      log('Event: $event');
      log('--------------------');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      log('--- BLoC Error ---');
      log('Bloc: ${bloc.runtimeType}');
      log('Error: $error');
      log('StackTrace: $stackTrace');
      log('--------------------');
    }
    super.onError(bloc, error, stackTrace);
  }
}