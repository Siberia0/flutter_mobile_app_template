import 'package:flutter_mobile_app_template/common/usecase/environment_usecase.dart';
import 'package:flutter_mobile_app_template/const/operation_type.dart';
import 'package:flutter_mobile_app_template/repository/environment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'environment_usecase_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<EnvironmentRepository>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  group('getBuildType', () {
    test('unknown', () {
      final repository = MockEnvironmentRepository();
      when(repository.getOperationTypeString()).thenReturn('?');

      final useCase = EnvironmentUseCase.di(repository);
      expect(useCase.getOperationType() == OperationType.develop, isTrue);
    });

    test('develop', () {
      final repository = MockEnvironmentRepository();
      when(repository.getOperationTypeString()).thenReturn('develop');

      final useCase = EnvironmentUseCase.di(repository);
      expect(useCase.getOperationType() == OperationType.develop, isTrue);
    });

    test('review', () {
      final repository = MockEnvironmentRepository();
      when(repository.getOperationTypeString()).thenReturn('review');

      final useCase = EnvironmentUseCase.di(repository);
      expect(useCase.getOperationType() == OperationType.review, isTrue);
    });

    test('staging', () {
      final repository = MockEnvironmentRepository();
      when(repository.getOperationTypeString()).thenReturn('staging');

      final useCase = EnvironmentUseCase.di(repository);
      expect(useCase.getOperationType() == OperationType.staging, isTrue);
    });

    test('product', () {
      final repository = MockEnvironmentRepository();
      when(repository.getOperationTypeString()).thenReturn('product');

      final useCase = EnvironmentUseCase.di(repository);
      expect(useCase.getOperationType() == OperationType.product, isTrue);
    });
  });
}
