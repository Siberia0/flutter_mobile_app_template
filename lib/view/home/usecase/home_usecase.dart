import 'package:flutter/material.dart';
import 'package:flutter_mobile_app_template/entity/user/user_entity.dart';

import '../../../common/usecase/rest_api_usecase.dart';
import '../../../repository/rest_api/rest_api_repository.dart';

class HomeUseCase {
  final RestApiUseCase _apiUseCase;
  HomeUseCase() : this.di(RestApiUseCase());

  @visibleForTesting
  HomeUseCase.di(this._apiUseCase);

  Future<UserEntity> requestRestApi(
      {required String path,
      required HttpMethod method,
      dynamic body,
      int timeOutSeconds = 60}) async {
    final response = await _apiUseCase.request(
        path: path, method: method, body: body, timeOutSeconds: timeOutSeconds);
    return UserEntity.fromJson(response);
  }

  void close() => _apiUseCase.close();
}
