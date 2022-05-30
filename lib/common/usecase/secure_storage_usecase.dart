import 'dart:convert';
import 'dart:typed_data';

import '../../repository/secure_storage_repository.dart';

class SecureStorageUseCase {
  final SecureStorageRepository _repository;
  SecureStorageUseCase() : this.di(SecureStorageRepository());
  SecureStorageUseCase.di(this._repository);

  static const _encryptKeyName = '5GztRFW9D5ns';

  /// Read encryption key
  /// - Decode in base64
  Future<Uint8List?> readEncryptKey() async {
    final encodedEncryptKey = await _repository.read(key: _encryptKeyName);
    return (encodedEncryptKey != null)
        ? base64Url.decode(encodedEncryptKey)
        : null;
  }

  /// Write encryption key
  /// - Encode in base64
  Future<void> writeEncryptKey({
    required List<int> bytes,
  }) async {
    await _repository.write(
        key: _encryptKeyName, value: base64UrlEncode(bytes));
  }
}
