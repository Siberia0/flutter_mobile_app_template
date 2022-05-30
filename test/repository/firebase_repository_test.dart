import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_mobile_app_template/repository/firebase_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_repository_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FirebaseApp>(returnNullOnMissingStub: true),
  MockSpec<FirebaseRemoteConfig>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  test('init', () async {
    bool result = false;

    final repository = FirebaseRepository.di(
      ({name, options}) {
        result = true;
        return Future.value(MockFirebaseApp());
      },
      ({callOptions, screenClassOverride = '', screenName}) => Future.value(),
      ({callOptions, name = '', parameters}) => Future.value(),
      (exception, stack,
              {fatal = false, information = const [], printDetails, reason}) =>
          Future.value(),
      (flutterErrorDetails, {fatal = false}) => Future.value(),
      ({callOptions, id}) => Future.value(),
      (identifier) => Future.value(),
      MockFirebaseRemoteConfig(),
    );

    await repository.init();
    expect(result, isTrue);
  });

  test('setUserId', () async {
    bool result1 = false;
    bool result2 = false;

    final repository = FirebaseRepository.di(
      ({name, options}) => Future.value(MockFirebaseApp()),
      ({callOptions, screenClassOverride = '', screenName}) => Future.value(),
      ({callOptions, name = '', parameters}) => Future.value(),
      (exception, stack,
              {fatal = false, information = const [], printDetails, reason}) =>
          Future.value(),
      (flutterErrorDetails, {fatal = false}) => Future.value(),
      ({callOptions, id}) {
        result1 = true;
        return Future.value();
      },
      (identifier) {
        result2 = true;
        return Future.value();
      },
      MockFirebaseRemoteConfig(),
    );

    await repository.setUserId('');
    expect(result1 && result2, isTrue);
  });

  test('logCurrentScreen', () async {
    bool result = false;

    final repository = FirebaseRepository.di(
      ({name, options}) => Future.value(MockFirebaseApp()),
      ({callOptions, screenClassOverride = '', screenName}) {
        result = true;
        return Future.value();
      },
      ({callOptions, name = '', parameters}) => Future.value(),
      (exception, stack,
              {fatal = false, information = const [], printDetails, reason}) =>
          Future.value(),
      (flutterErrorDetails, {fatal = false}) => Future.value(),
      ({callOptions, id}) => Future.value(),
      (identifier) => Future.value(),
      MockFirebaseRemoteConfig(),
    );

    await repository.logCurrentScreen('');
    expect(result, isTrue);
  });

  test('logAppError', () async {
    bool result = false;

    final repository = FirebaseRepository.di(
      ({name, options}) => Future.value(MockFirebaseApp()),
      ({callOptions, screenClassOverride = '', screenName}) => Future.value(),
      ({callOptions, name = '', parameters}) {
        result = true;
        return Future.value();
      },
      (exception, stack,
              {fatal = false, information = const [], printDetails, reason}) =>
          Future.value(),
      (flutterErrorDetails, {fatal = false}) => Future.value(),
      ({callOptions, id}) => Future.value(),
      (identifier) => Future.value(),
      MockFirebaseRemoteConfig(),
    );

    await repository.logAppError('');
    expect(result, isTrue);
  });

  test('recordError', () async {
    bool result = false;

    final repository = FirebaseRepository.di(
      ({name, options}) => Future.value(MockFirebaseApp()),
      ({callOptions, screenClassOverride = '', screenName}) => Future.value(),
      ({callOptions, name = '', parameters}) => Future.value(),
      (exception, stack,
          {fatal = false, information = const [], printDetails, reason}) {
        result = true;
        return Future.value();
      },
      (flutterErrorDetails, {fatal = false}) => Future.value(),
      ({callOptions, id}) => Future.value(),
      (identifier) => Future.value(),
      MockFirebaseRemoteConfig(),
    );

    await repository.recordError(Exception());
    expect(result, isTrue);
  });

  test('recordFlutterError', () async {
    bool result = false;

    final repository = FirebaseRepository.di(
      ({name, options}) => Future.value(MockFirebaseApp()),
      ({callOptions, screenClassOverride = '', screenName}) => Future.value(),
      ({callOptions, name = '', parameters}) => Future.value(),
      (exception, stack,
              {fatal = false, information = const [], printDetails, reason}) =>
          Future.value(),
      (flutterErrorDetails, {fatal = false}) {
        result = true;
        return Future.value();
      },
      ({callOptions, id}) => Future.value(),
      (identifier) => Future.value(),
      MockFirebaseRemoteConfig(),
    );

    await repository.recordFlutterError(Exception());
    expect(result, isTrue);
  });

  test('fetchServiceMaintenanceFlag', () async {
    final mock = MockFirebaseRemoteConfig();
    when(mock.setConfigSettings(any))
        .thenAnswer((realInvocation) => Future.value());
    when(mock.fetch()).thenAnswer((realInvocation) => Future.value());
    when(mock.activate()).thenAnswer((realInvocation) => Future.value(true));
    when(mock.getBool(any)).thenReturn(false);

    final repository = FirebaseRepository.di(
      ({name, options}) => Future.value(MockFirebaseApp()),
      ({callOptions, screenClassOverride = '', screenName}) => Future.value(),
      ({callOptions, name = '', parameters}) => Future.value(),
      (exception, stack,
              {fatal = false, information = const [], printDetails, reason}) =>
          Future.value(),
      (flutterErrorDetails, {fatal = false}) => Future.value(),
      ({callOptions, id}) => Future.value(),
      (identifier) => Future.value(),
      mock,
    );

    final result = await repository.fetchServiceMaintenanceFlag(
        const Duration(minutes: 3), const Duration(minutes: 30));
    expect(result, isFalse);
  });
}
