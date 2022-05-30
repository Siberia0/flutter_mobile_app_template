import 'package:flutter_mobile_app_template/common/usecase/secure_storage_usecase.dart';
import 'package:flutter_mobile_app_template/repository/secure_storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'secure_storage_usecase_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SecureStorageRepository>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  group('readEncryptKey', () {
    test('not exists', () async {
      final repository = MockSecureStorageRepository();
      when(repository.read(key: anyNamed('key')))
          .thenAnswer((realInvocation) => Future.value(null));

      final useCase = SecureStorageUseCase.di(repository);
      final result = await useCase.readEncryptKey();
      expect(result, isNull);
    });

    test('exists', () async {
      final repository = MockSecureStorageRepository();
      when(repository.read(key: anyNamed('key')))
          .thenAnswer((realInvocation) => Future.value('aGVsbG8='));

      final useCase = SecureStorageUseCase.di(repository);
      final result = await useCase.readEncryptKey();
      expect(result != null && String.fromCharCodes(result) == 'hello', isTrue);
    });
  });

  test('writeEncryptKey', () async {
    final repository = MockSecureStorageRepository();
    when(repository.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenAnswer((realInvocation) => Future.value(null));

    final useCase = SecureStorageUseCase.di(repository);
    expect(() async => await useCase.writeEncryptKey(bytes: [1, 2]),
        returnsNormally);
  });
}
