import 'package:flutter_mobile_app_template/common/usecase/firebase_usecase.dart';
import 'package:flutter_mobile_app_template/repository/firebase_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_usecase_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FirebaseRepository>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  test('init', () async {
    final repository = MockFirebaseRepository();
    when(repository.init()).thenAnswer((realInvocation) => Future.value());

    final useCase = FirebaseUseCase.di(repository);
    expect(() async => await useCase.init(), returnsNormally);
  });

  test('setUserId', () async {
    final repository = MockFirebaseRepository();
    when(repository.setUserId(any))
        .thenAnswer((realInvocation) => Future.value());

    final useCase = FirebaseUseCase.di(repository);
    expect(() async => await useCase.setUserId(''), returnsNormally);
  });

  test('logCurrentScreen', () async {
    final repository = MockFirebaseRepository();
    when(repository.logCurrentScreen(any))
        .thenAnswer((realInvocation) => Future.value());

    final useCase = FirebaseUseCase.di(repository);
    expect(() async => await useCase.logCurrentScreen(''), returnsNormally);
  });

  test('logAppError', () async {
    final repository = MockFirebaseRepository();
    when(repository.logAppError(any))
        .thenAnswer((realInvocation) => Future.value());

    final useCase = FirebaseUseCase.di(repository);
    expect(() async => await useCase.logAppError(''), returnsNormally);
  });

  test('recordError', () async {
    final repository = MockFirebaseRepository();
    when(repository.recordError(any))
        .thenAnswer((realInvocation) => Future.value());

    final useCase = FirebaseUseCase.di(repository);
    expect(() async => await useCase.recordError(''), returnsNormally);
  });

  test('fetchServiceMaintenanceFlag', () async {
    final repository = MockFirebaseRepository();
    when(repository.fetchServiceMaintenanceFlag(any, any))
        .thenAnswer((realInvocation) => Future.value(false));

    final useCase = FirebaseUseCase.di(repository);
    final result = await useCase.fetchServiceMaintenanceFlag();
    expect(result, isFalse);
  });
}
