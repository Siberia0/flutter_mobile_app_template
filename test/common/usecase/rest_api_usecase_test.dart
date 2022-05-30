import 'dart:io';

import 'package:flutter_mobile_app_template/common/usecase/environment_usecase.dart';
import 'package:flutter_mobile_app_template/common/usecase/firebase_usecase.dart';
import 'package:flutter_mobile_app_template/common/usecase/rest_api_usecase.dart';
import 'package:flutter_mobile_app_template/const/operation_type.dart';
import 'package:flutter_mobile_app_template/exception/app_exception.dart';
import 'package:flutter_mobile_app_template/repository/rest_api/rest_api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rest_api_usecase_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<RestApiRepository>(returnNullOnMissingStub: true),
  MockSpec<FirebaseUseCase>(returnNullOnMissingStub: true),
  MockSpec<EnvironmentUseCase>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  final firebaseUseCase = MockFirebaseUseCase();
  final environmentUseCase = MockEnvironmentUseCase();
  when(environmentUseCase.getOperationType()).thenReturn(OperationType.develop);

  group('request', () {
    test('success', () async {
      final repository = MockRestApiRepository();
      when(repository.request(
              url: anyNamed('url'),
              method: anyNamed('method'),
              body: anyNamed('body'),
              timeOutSeconds: anyNamed('timeOutSeconds')))
          .thenAnswer((realInvocation) {
        return Future.value({'key': 'value'});
      });

      final useCase =
          RestApiUseCase.di(repository, firebaseUseCase, environmentUseCase);
      final result = await useCase.request(
          path: '/test', method: HttpMethod.get, timeOutSeconds: 60);
      expect(result.containsKey('key'), isTrue);
    });

    test('exception occurred: SocketException', () async {
      final repository = MockRestApiRepository();
      when(repository.request(
              url: anyNamed('url'),
              method: anyNamed('method'),
              body: anyNamed('body'),
              timeOutSeconds: anyNamed('timeOutSeconds')))
          .thenThrow(const SocketException(''));

      final useCase =
          RestApiUseCase.di(repository, firebaseUseCase, environmentUseCase);
      expect(
          () async => await useCase.request(
              path: '/test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) => e is AppException)));
    });

    test('exception occurred: other exception', () async {
      final repository = MockRestApiRepository();
      when(repository.request(
              url: anyNamed('url'),
              method: anyNamed('method'),
              body: anyNamed('body'),
              timeOutSeconds: anyNamed('timeOutSeconds')))
          .thenThrow(Exception());

      final useCase =
          RestApiUseCase.di(repository, firebaseUseCase, environmentUseCase);
      expect(
          () async => await useCase.request(
              path: '/test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) => e is AppException)));
    });
  });

  test('close', () async {
    bool result = false;
    final repository = MockRestApiRepository();
    when(repository.close()).thenAnswer((realInvocation) {
      result = true;
    });

    final useCase =
        RestApiUseCase.di(repository, firebaseUseCase, environmentUseCase);
    useCase.close();
    expect(result, isTrue);
  });
}
