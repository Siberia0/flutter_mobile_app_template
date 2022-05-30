// Mocks generated by Mockito 5.2.0 from annotations
// in flutter_mobile_app_template/test/repository/hive_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:typed_data' as _i7;

import 'package:hive/hive.dart' as _i2;
import 'package:hive/src/box/default_compaction_strategy.dart' as _i6;
import 'package:hive/src/box/default_key_comparator.dart' as _i5;
import 'package:hive/src/hive_impl.dart' as _i3;
import 'package:hive/src/registry/type_registry_impl.dart' as _i8;
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

class _FakeBox_0<E> extends _i1.Fake implements _i2.Box<E> {}

class _FakeLazyBox_1<E> extends _i1.Fake implements _i2.LazyBox<E> {}

/// A class which mocks [HiveImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveImpl extends _i1.Mock implements _i3.HiveImpl {
  @override
  set homePath(String? _homePath) =>
      super.noSuchMethod(Invocation.setter(#homePath, _homePath),
          returnValueForMissingStub: null);
  @override
  void init(String? path,
          {_i2.HiveStorageBackendPreference? backendPreference =
              _i2.HiveStorageBackendPreference.native}) =>
      super.noSuchMethod(
          Invocation.method(
              #init, [path], {#backendPreference: backendPreference}),
          returnValueForMissingStub: null);
  @override
  _i4.Future<_i2.Box<E>> openBox<E>(String? name,
          {_i2.HiveCipher? encryptionCipher,
          _i2.KeyComparator? keyComparator = _i5.defaultKeyComparator,
          _i2.CompactionStrategy? compactionStrategy =
              _i6.defaultCompactionStrategy,
          bool? crashRecovery = true,
          String? path,
          _i7.Uint8List? bytes,
          String? collection,
          List<int>? encryptionKey}) =>
      (super.noSuchMethod(
              Invocation.method(#openBox, [
                name
              ], {
                #encryptionCipher: encryptionCipher,
                #keyComparator: keyComparator,
                #compactionStrategy: compactionStrategy,
                #crashRecovery: crashRecovery,
                #path: path,
                #bytes: bytes,
                #collection: collection,
                #encryptionKey: encryptionKey
              }),
              returnValue: Future<_i2.Box<E>>.value(_FakeBox_0<E>()))
          as _i4.Future<_i2.Box<E>>);
  @override
  _i4.Future<_i2.LazyBox<E>> openLazyBox<E>(String? name,
          {_i2.HiveCipher? encryptionCipher,
          _i2.KeyComparator? keyComparator = _i5.defaultKeyComparator,
          _i2.CompactionStrategy? compactionStrategy =
              _i6.defaultCompactionStrategy,
          bool? crashRecovery = true,
          String? path,
          String? collection,
          List<int>? encryptionKey}) =>
      (super.noSuchMethod(
              Invocation.method(#openLazyBox, [
                name
              ], {
                #encryptionCipher: encryptionCipher,
                #keyComparator: keyComparator,
                #compactionStrategy: compactionStrategy,
                #crashRecovery: crashRecovery,
                #path: path,
                #collection: collection,
                #encryptionKey: encryptionKey
              }),
              returnValue: Future<_i2.LazyBox<E>>.value(_FakeLazyBox_1<E>()))
          as _i4.Future<_i2.LazyBox<E>>);
  @override
  _i2.BoxBase<dynamic>? getBoxWithoutCheckInternal(String? name) => (super
          .noSuchMethod(Invocation.method(#getBoxWithoutCheckInternal, [name]))
      as _i2.BoxBase<dynamic>?);
  @override
  _i2.Box<E> box<E>(String? name) =>
      (super.noSuchMethod(Invocation.method(#box, [name]),
          returnValue: _FakeBox_0<E>()) as _i2.Box<E>);
  @override
  _i2.LazyBox<E> lazyBox<E>(String? name) =>
      (super.noSuchMethod(Invocation.method(#lazyBox, [name]),
          returnValue: _FakeLazyBox_1<E>()) as _i2.LazyBox<E>);
  @override
  bool isBoxOpen(String? name) =>
      (super.noSuchMethod(Invocation.method(#isBoxOpen, [name]),
          returnValue: false) as bool);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void unregisterBox(String? name) =>
      super.noSuchMethod(Invocation.method(#unregisterBox, [name]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> deleteBoxFromDisk(String? name,
          {String? path, String? collection}) =>
      (super.noSuchMethod(
          Invocation.method(#deleteBoxFromDisk, [name],
              {#path: path, #collection: collection}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteFromDisk() =>
      (super.noSuchMethod(Invocation.method(#deleteFromDisk, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  List<int> generateSecureKey() =>
      (super.noSuchMethod(Invocation.method(#generateSecureKey, []),
          returnValue: <int>[]) as List<int>);
  @override
  _i4.Future<bool> boxExists(String? name,
          {String? path, String? collection}) =>
      (super.noSuchMethod(
          Invocation.method(
              #boxExists, [name], {#path: path, #collection: collection}),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i8.ResolvedAdapter<dynamic>? findAdapterForTypeId(int? typeId) =>
      (super.noSuchMethod(Invocation.method(#findAdapterForTypeId, [typeId]))
          as _i8.ResolvedAdapter<dynamic>?);
  @override
  void registerAdapter<T>(_i2.TypeAdapter<T>? adapter,
          {bool? internal = false, bool? override = false}) =>
      super.noSuchMethod(
          Invocation.method(#registerAdapter, [adapter],
              {#internal: internal, #override: override}),
          returnValueForMissingStub: null);
  @override
  bool isAdapterRegistered(int? typeId, {bool? internal = false}) =>
      (super.noSuchMethod(
          Invocation.method(
              #isAdapterRegistered, [typeId], {#internal: internal}),
          returnValue: false) as bool);
  @override
  void resetAdapters() =>
      super.noSuchMethod(Invocation.method(#resetAdapters, []),
          returnValueForMissingStub: null);
  @override
  void ignoreTypeId<T>(int? typeId) =>
      super.noSuchMethod(Invocation.method(#ignoreTypeId, [typeId]),
          returnValueForMissingStub: null);
}

/// A class which mocks [Box].
///
/// See the documentation for Mockito's code generation for more information.
class MockBox<E> extends _i1.Mock implements _i2.Box<E> {
  @override
  Iterable<E> get values =>
      (super.noSuchMethod(Invocation.getter(#values), returnValue: <E>[])
          as Iterable<E>);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  bool get isOpen =>
      (super.noSuchMethod(Invocation.getter(#isOpen), returnValue: false)
          as bool);
  @override
  bool get lazy =>
      (super.noSuchMethod(Invocation.getter(#lazy), returnValue: false)
          as bool);
  @override
  Iterable<dynamic> get keys =>
      (super.noSuchMethod(Invocation.getter(#keys), returnValue: <dynamic>[])
          as Iterable<dynamic>);
  @override
  int get length =>
      (super.noSuchMethod(Invocation.getter(#length), returnValue: 0) as int);
  @override
  bool get isEmpty =>
      (super.noSuchMethod(Invocation.getter(#isEmpty), returnValue: false)
          as bool);
  @override
  bool get isNotEmpty =>
      (super.noSuchMethod(Invocation.getter(#isNotEmpty), returnValue: false)
          as bool);
  @override
  Iterable<E> valuesBetween({dynamic startKey, dynamic endKey}) =>
      (super.noSuchMethod(
          Invocation.method(
              #valuesBetween, [], {#startKey: startKey, #endKey: endKey}),
          returnValue: <E>[]) as Iterable<E>);
  @override
  E? getAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#getAt, [index])) as E?);
  @override
  Map<dynamic, E> toMap() => (super.noSuchMethod(Invocation.method(#toMap, []),
      returnValue: <dynamic, E>{}) as Map<dynamic, E>);
  @override
  dynamic keyAt(int? index) =>
      super.noSuchMethod(Invocation.method(#keyAt, [index]));
  @override
  _i4.Stream<_i2.BoxEvent> watch({dynamic key}) => (super.noSuchMethod(
      Invocation.method(#watch, [], {#key: key}),
      returnValue: Stream<_i2.BoxEvent>.empty()) as _i4.Stream<_i2.BoxEvent>);
  @override
  bool containsKey(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#containsKey, [key]),
          returnValue: false) as bool);
  @override
  _i4.Future<void> put(dynamic key, E? value) =>
      (super.noSuchMethod(Invocation.method(#put, [key, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> putAt(int? index, E? value) =>
      (super.noSuchMethod(Invocation.method(#putAt, [index, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> putAll(Map<dynamic, E>? entries) =>
      (super.noSuchMethod(Invocation.method(#putAll, [entries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<int> add(E? value) =>
      (super.noSuchMethod(Invocation.method(#add, [value]),
          returnValue: Future<int>.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<Iterable<int>> addAll(Iterable<E>? values) =>
      (super.noSuchMethod(Invocation.method(#addAll, [values]),
              returnValue: Future<Iterable<int>>.value(<int>[]))
          as _i4.Future<Iterable<int>>);
  @override
  _i4.Future<void> delete(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#delete, [key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#deleteAt, [index]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteAll(Iterable<dynamic>? keys) =>
      (super.noSuchMethod(Invocation.method(#deleteAll, [keys]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> compact() =>
      (super.noSuchMethod(Invocation.method(#compact, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<int> clear() => (super.noSuchMethod(Invocation.method(#clear, []),
      returnValue: Future<int>.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteFromDisk() =>
      (super.noSuchMethod(Invocation.method(#deleteFromDisk, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> flush() => (super.noSuchMethod(Invocation.method(#flush, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}
