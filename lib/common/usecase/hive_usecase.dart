import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_app_template/common/usecase/secure_storage_usecase.dart';
import 'package:flutter_mobile_app_template/exception/app_exception.dart';

import '../../repository/hive_repository.dart';

class HiveUseCase {
  final HiveRepository _repository;
  final SecureStorageUseCase _secureStorageUseCase;
  HiveUseCase() : this.di(HiveRepository(), SecureStorageUseCase());

  @visibleForTesting
  HiveUseCase.di(this._repository, this._secureStorageUseCase);

  static const _boxName = 'box';

  static const _keyNameSignInID = 'signInID';

  Future<void> init() async {
    // Get the encryption key for encrypting Hive from SecureStorage
    Uint8List? byteEncryptKey = await _secureStorageUseCase.readEncryptKey();
    if (byteEncryptKey == null) {
      // If it does not exist, create a new one.
      final byteSecureKey = _repository.generateSecureKey();
      await _secureStorageUseCase.writeEncryptKey(bytes: byteSecureKey);
      // Retrieve again
      byteEncryptKey = await _secureStorageUseCase.readEncryptKey();
    }

    // Exception if null here
    if (byteEncryptKey == null) {
      throw AppException('Failed reading from secure storage.');
    }

    await _repository.init(_boxName, byteEncryptKey);
  }

  /// Sign-in ID

  Future<void> storeSignInId(String id) async {
    await _repository.put(_keyNameSignInID, id);
  }

  String readSignInId() {
    return _repository.get(_keyNameSignInID) ?? '';
  }
}
