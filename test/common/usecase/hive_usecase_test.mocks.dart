// Mocks generated by Mockito 5.2.0 from annotations
// in flutter_mobile_app_template/test/common/usecase/hive_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;

import 'package:flutter_mobile_app_template/common/usecase/secure_storage_usecase.dart'
    as _i5;
import 'package:flutter_mobile_app_template/repository/hive_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [HiveRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveRepository extends _i1.Mock implements _i2.HiveRepository {
  @override
  _i3.Future<void> init(String? boxName, _i4.Uint8List? listEncryptKey) =>
      (super.noSuchMethod(Invocation.method(#init, [boxName, listEncryptKey]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  dynamic get(String? key) =>
      super.noSuchMethod(Invocation.method(#get, [key]));
  @override
  _i3.Future<void> put(String? key, dynamic value) =>
      (super.noSuchMethod(Invocation.method(#put, [key, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  List<int> generateSecureKey() =>
      (super.noSuchMethod(Invocation.method(#generateSecureKey, []),
          returnValue: <int>[]) as List<int>);
}

/// A class which mocks [SecureStorageUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSecureStorageUseCase extends _i1.Mock
    implements _i5.SecureStorageUseCase {
  @override
  _i3.Future<_i4.Uint8List?> readEncryptKey() =>
      (super.noSuchMethod(Invocation.method(#readEncryptKey, []),
              returnValue: Future<_i4.Uint8List?>.value())
          as _i3.Future<_i4.Uint8List?>);
  @override
  _i3.Future<void> writeEncryptKey({List<int>? bytes}) => (super.noSuchMethod(
      Invocation.method(#writeEncryptKey, [], {#bytes: bytes}),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}