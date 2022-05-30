import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// singleton
class SecureStorageRepository {
  final FlutterSecureStorage _secureStorage;

  static SecureStorageRepository? _instance;
  factory SecureStorageRepository() => _instance ??=
      SecureStorageRepository._internal(const FlutterSecureStorage());
  SecureStorageRepository._internal(this._secureStorage);

  @visibleForTesting
  SecureStorageRepository.di(this._secureStorage);

  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> write({
    required String key,
    required String? value,
  }) async {
    await _secureStorage.write(key: key, value: value);
  }
}
