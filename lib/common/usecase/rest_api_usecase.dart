import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_app_template/exception/app_exception.dart';

import '../../const/operation_type.dart';
import '../../exception/api_exception.dart';
import '../../repository/rest_api/rest_api_repository.dart';
import 'environment_usecase.dart';
import 'firebase_usecase.dart';

class RestApiUseCase {
  // API endpoint
  late final String _endPoint;

  final RestApiRepository _repository;
  final FirebaseUseCase _firebaseUseCase;
  RestApiUseCase()
      : this.di(RestApiRepository(), FirebaseUseCase(), EnvironmentUseCase());

  @visibleForTesting
  RestApiUseCase.di(
      this._repository, this._firebaseUseCase, EnvironmentUseCase env) {
    // Branch API endpoints by environment variables
    switch (env.getOperationType()) {
      case OperationType.product:
        _endPoint = 'https://~~~';
        break;
      case OperationType.staging:
        _endPoint = 'https://~~~';
        break;
      case OperationType.review:
        _endPoint = 'https://~~~';
        break;
      case OperationType.develop:
        _endPoint = 'https://~~~';
        break;
    }
  }

  void close() {
    _repository.close();
  }

  Future<Map<String, dynamic>> request(
      {required String path,
      required HttpMethod method,
      dynamic body,
      required int timeOutSeconds}) async {
    try {
      return await _repository.request(
          url: _getUrl(path),
          method: method,
          body: body,
          timeOutSeconds: timeOutSeconds);
    } on SocketException catch (e) {
      // Logging as application error
      _firebaseUseCase.logAppError(e.toString());
      // rethrow as AppException
      throw AppException('No valid network connection', exception: e);
    } on ApiException catch (e) {
      // Logging as application error
      _firebaseUseCase.logAppError(
          'ApiException\n  - url: ${method.string} ${_getUrl(path)}\n  - statusCode: ${e.statusCode}');
      rethrow;
    } catch (e) {
      // Logging as application error
      _firebaseUseCase.logAppError(e.toString());
      // rethrow as AppException
      throw AppException('Unknown error occurred', exception: e);
    }
  }

  String _getUrl(String path) {
    if (path.isNotEmpty && path[0] != '/') {
      return '$_endPoint/$path';
    } else {
      return '$_endPoint$path';
    }
  }
}
