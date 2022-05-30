import 'package:flutter_mobile_app_template/repository/secure_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'secure_storage_repository_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FlutterSecureStorage>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  test('read', () async {
    final secureStorage = MockFlutterSecureStorage();
    when(secureStorage.read(key: anyNamed('key')))
        .thenAnswer((realInvocation) => Future.value('hello'));

    final repository = SecureStorageRepository.di(
      secureStorage,
    );

    final result = await repository.read(key: 'test');
    expect(result == 'hello', isTrue);
  });

  test('write', () async {
    final secureStorage = MockFlutterSecureStorage();
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenAnswer((realInvocation) => Future.value());

    final repository = SecureStorageRepository.di(
      secureStorage,
    );

    expect(() async => await repository.write(key: 'key', value: 'value'),
        returnsNormally);
  });
}
