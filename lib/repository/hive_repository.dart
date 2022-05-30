import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef InitHiveFunction = Future<void> Function([String? subDir]);
typedef OpenHiveBoxFunction = Future<Box<E>> Function<E>(
  String name, {
  HiveCipher? encryptionCipher,
  KeyComparator keyComparator,
  CompactionStrategy compactionStrategy,
  bool crashRecovery,
  String? path,
  Uint8List? bytes,
  List<int>? encryptionKey,
});
typedef GenerateSecureKeyHiveFunction = List<int> Function();

/// singleton
class HiveRepository {
  // Allows for replacement
  final InitHiveFunction _initHiveFunction;
  final OpenHiveBoxFunction _openHiveBoxFunction;
  final GenerateSecureKeyHiveFunction _generateSecureKeyHiveFunction;

  static HiveRepository? _instance;
  factory HiveRepository() => _instance ??= HiveRepository._internal(
      Hive.initFlutter, Hive.openBox, Hive.generateSecureKey);
  HiveRepository._internal(this._initHiveFunction, this._openHiveBoxFunction,
      this._generateSecureKeyHiveFunction);

  @visibleForTesting
  HiveRepository.di(this._initHiveFunction, this._openHiveBoxFunction,
      this._generateSecureKeyHiveFunction);

  late Box _box;

  /// initialization process
  Future<void> init(String boxName, Uint8List listEncryptKey) async {
    await _initHiveFunction();
    _box = await _openHiveBoxFunction(boxName,
        encryptionCipher: HiveAesCipher(listEncryptKey));
  }

  /// read
  dynamic get(String key) {
    return _box.get(key);
  }

  /// write
  Future<void> put(String key, dynamic value) async {
    return await _box.put(key, value);
  }

  /// Generate a random string that can be used as an encryption key
  List<int> generateSecureKey() {
    return _generateSecureKeyHiveFunction();
  }
}
