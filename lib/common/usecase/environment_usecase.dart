import 'package:flutter/cupertino.dart';

import '../../const/operation_type.dart';
import '../../repository/environment_repository.dart';

/// singleton
class EnvironmentUseCase {
  final EnvironmentRepository _repository;

  static EnvironmentUseCase? _instance;
  factory EnvironmentUseCase() =>
      _instance ??= EnvironmentUseCase._internal(EnvironmentRepository());
  EnvironmentUseCase._internal(this._repository);

  @visibleForTesting
  EnvironmentUseCase.di(this._repository);

  OperationType getOperationType() {
    switch (_repository.getOperationTypeString()) {
      case 'product':
        return OperationType.product;
      case 'staging':
        return OperationType.staging;
      case 'review':
        return OperationType.review;
      case 'develop':
        return OperationType.develop;
      default:
        return OperationType.develop;
    }
  }
}
