import 'dart:typed_data';

import 'package:flutter_mobile_app_template/repository/hive_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/src/hive_impl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_repository_test.mocks.dart';

int defaultKeyComparator(dynamic k1, dynamic k2) {
  if (k1 is int) {
    if (k2 is int) {
      if (k1 > k2) {
        return 1;
      } else if (k1 < k2) {
        return -1;
      } else {
        return 0;
      }
    } else {
      return -1;
    }
  } else if (k2 is String) {
    return (k1 as String).compareTo(k2);
  } else {
    return 1;
  }
}

const _deletedRatio = 0.15;
const _deletedThreshold = 60;
bool defaultCompactionStrategy(int entries, int deletedEntries) {
  return deletedEntries > _deletedThreshold &&
      deletedEntries / entries > _deletedRatio;
}

@GenerateMocks([], customMocks: [
  MockSpec<HiveImpl>(returnNullOnMissingStub: true),
  MockSpec<Box>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  test('init', () async {
    final MockBox<int> mockBox = MockBox<int>();

    final repository = HiveRepository.di(
      ([subDir]) => Future.value(),
      <int>(name,
              {bytes,
              compactionStrategy = defaultCompactionStrategy,
              crashRecovery = true,
              encryptionCipher,
              encryptionKey,
              keyComparator = defaultKeyComparator,
              path}) =>
          Future.value(mockBox) as Future<Box<int>>,
      () => [],
    );

    expect(
        () async => await repository.init(
            'box', Uint8List.fromList(Hive.generateSecureKey())),
        returnsNormally);
  });

  test('get', () async {
    final MockBox<int> mockBox = MockBox<int>();
    when(mockBox.get(any)).thenReturn(1);

    final repository = HiveRepository.di(
      ([subDir]) => Future.value(),
      //a.a,
      <int>(name,
              {bytes,
              compactionStrategy = defaultCompactionStrategy,
              crashRecovery = true,
              encryptionCipher,
              encryptionKey,
              keyComparator = defaultKeyComparator,
              path}) =>
          Future.value(mockBox) as Future<Box<int>>,
      () => [],
    );

    await repository.init('box', Uint8List.fromList(Hive.generateSecureKey()));
    expect(repository.get('key') == 1, isTrue);
  });

  test('put', () async {
    final MockBox<int> mockBox = MockBox<int>();
    when(mockBox.put(any, any));

    final repository = HiveRepository.di(
      ([subDir]) => Future.value(),
      //a.a,
      <int>(name,
              {bytes,
              compactionStrategy = defaultCompactionStrategy,
              crashRecovery = true,
              encryptionCipher,
              encryptionKey,
              keyComparator = defaultKeyComparator,
              path}) =>
          Future.value(mockBox) as Future<Box<int>>,
      () => [],
    );

    await repository.init('box', Uint8List.fromList(Hive.generateSecureKey()));
    expect(() async => await repository.put('key', 1), returnsNormally);
  });
}
