import 'package:flutter/cupertino.dart';

import '../../repository/firebase_repository.dart';

class FirebaseUseCase {
  final FirebaseRepository _repository;
  FirebaseUseCase() : this.di(FirebaseRepository());
  @visibleForTesting
  FirebaseUseCase.di(this._repository);

  // initialization process
  Future<void> init() async {
    await _repository.init();

    // Uncaught errors are handled here.
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await _repository.recordFlutterError(errorDetails.exception,
          stackTrace: errorDetails.stack);
      // Forward to original handler.
      FlutterError.onError!(errorDetails);
    };
  }

  // ID Settings
  Future<void> setUserId(String id) async => await _repository.setUserId(id);

  // Screen transition logging
  Future<void> logCurrentScreen(String screenName) async =>
      await _repository.logCurrentScreen(screenName);

  // App error logging
  Future<void> logAppError(String errorLog) async =>
      await _repository.logAppError(errorLog);

  // Error Reporting to CrashLytics
  Future<void> recordError(Object exception, {StackTrace? stackTrace}) async =>
      await _repository.recordError(exception, stackTrace: stackTrace);

  // Get maintenance flags
  Future<bool> fetchServiceMaintenanceFlag() async {
    return await _repository.fetchServiceMaintenanceFlag(
        const Duration(minutes: 3), const Duration(minutes: 30));
  }
}
