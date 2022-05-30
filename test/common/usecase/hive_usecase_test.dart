import 'dart:typed_data';

import 'package:flutter_mobile_app_template/common/usecase/hive_usecase.dart';
import 'package:flutter_mobile_app_template/common/usecase/secure_storage_usecase.dart';
import 'package:flutter_mobile_app_template/exception/app_exception.dart';
import 'package:flutter_mobile_app_template/repository/hive_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_usecase_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<HiveRepository>(returnNullOnMissingStub: true),
  MockSpec<SecureStorageUseCase>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  group('init', () {
    test('encrypt key read failed', () async {
      final repository = MockHiveRepository();
      when(repository.init(any, any))
          .thenAnswer((realInvocation) => Future.value());
      when(repository.generateSecureKey())
          .thenReturn(Uint8List.fromList(Hive.generateSecureKey()));

      final secureStorageUseCase = MockSecureStorageUseCase();
      when(secureStorageUseCase.readEncryptKey())
          .thenAnswer((realInvocation) => Future.value(null));

      final useCase = HiveUseCase.di(repository, secureStorageUseCase);
      expect(() async => await useCase.init(),
          throwsA(predicate((e) => e is AppException)));
    });

    test('encrypt key read success', () async {
      final repository = MockHiveRepository();
      when(repository.init(any, any))
          .thenAnswer((realInvocation) => Future.value());

      final secureStorageUseCase = MockSecureStorageUseCase();
      when(secureStorageUseCase.readEncryptKey()).thenAnswer((realInvocation) =>
          Future.value(Uint8List.fromList(Hive.generateSecureKey())));

      final useCase = HiveUseCase.di(repository, secureStorageUseCase);
      expect(() async => await useCase.init(), returnsNormally);
    });
  });

  test('storeSignInId', () async {
    final repository = MockHiveRepository();
    when(repository.put(any, any)).thenAnswer((realInvocation) {
      final args = realInvocation.positionalArguments;

      String value = args[1];
      expect(value == 'value', isTrue);

      return Future.value();
    });

    final secureStorageUseCase = MockSecureStorageUseCase();

    final useCase = HiveUseCase.di(repository, secureStorageUseCase);
    expect(() async => await useCase.storeSignInId('value'), returnsNormally);
  });

  test('readSignInId', () async {
    final repository = MockHiveRepository();
    when(repository.get(any)).thenReturn('value');

    final secureStorageUseCase = MockSecureStorageUseCase();

    final useCase = HiveUseCase.di(repository, secureStorageUseCase);
    expect(useCase.readSignInId() == 'value', isTrue);
  });
}
