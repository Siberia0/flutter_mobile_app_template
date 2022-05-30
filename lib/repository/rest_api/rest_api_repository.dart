import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../exception/api_exception.dart';
import 'rest_api_client_presenter.dart';

enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  final String string;
  const HttpMethod(this.string);
}

/// singleton
class RestApiRepository {
  final RestApiClientPresenter _clientPresenter;

  static RestApiRepository? _instance;
  factory RestApiRepository() =>
      _instance ??= RestApiRepository._internal(RestApiClientPresenter());
  RestApiRepository._internal(this._clientPresenter);

  @visibleForTesting
  RestApiRepository.di(this._clientPresenter);

  // Temporary assignment when key name does not exist
  static const String emptyKeyName = 'keyNameEmpty';

  void close() {
    _clientPresenter.close();
  }

  /// Perform HTTP request
  Future<Map<String, dynamic>> request(
      {required String url,
      required HttpMethod method,
      dynamic body,
      required int timeOutSeconds}) async {
    final http.Response response;
    try {
      switch (method) {
        case HttpMethod.get:
          response = await _clientPresenter
              .get(Uri.parse(url))
              .timeout(Duration(seconds: timeOutSeconds));
          break;
        case HttpMethod.put:
          response = await _clientPresenter
              .put(Uri.parse(url),
                  body: body != null ? json.encode(body) : null)
              .timeout(Duration(seconds: timeOutSeconds));
          break;
        case HttpMethod.patch:
          response = await _clientPresenter
              .patch(Uri.parse(url),
                  body: body != null ? json.encode(body) : null)
              .timeout(Duration(seconds: timeOutSeconds));
          break;
        case HttpMethod.post:
          response = await _clientPresenter
              .post(Uri.parse(url),
                  body: body != null ? json.encode(body) : null)
              .timeout(Duration(seconds: timeOutSeconds));
          break;
        case HttpMethod.delete:
          response = await _clientPresenter
              .delete(Uri.parse(url),
                  body: body != null ? json.encode(body) : null)
              .timeout(Duration(seconds: timeOutSeconds));
          break;
      }

      Map<String, dynamic> responseBody;

      final decodedBody =
          response.body.isNotEmpty ? json.decode(response.body) : null;
      if (decodedBody is Map<String, dynamic>) {
        responseBody = decodedBody;
      } else if (decodedBody is Iterable) {
        // Corresponds to a list without key names (key names are "emptyKeyName")
        responseBody = {emptyKeyName: decodedBody};
      } else {
        responseBody = {};
      }

      if (response.statusCode == 400) {
        throw ApiException(HttpStatusCode.badRequest,
            responseBody: responseBody);
      } else if (response.statusCode == 401) {
        throw ApiException(HttpStatusCode.unAuthorized,
            responseBody: responseBody);
      } else if (response.statusCode == 403) {
        throw ApiException(HttpStatusCode.forbidden,
            responseBody: responseBody);
      } else if (response.statusCode == 404) {
        throw ApiException(HttpStatusCode.notFound, responseBody: responseBody);
      } else if (response.statusCode == 409) {
        throw ApiException(HttpStatusCode.conflict, responseBody: responseBody);
      } else if (response.statusCode == 413) {
        throw ApiException(HttpStatusCode.requestTooLargeForGateway,
            responseBody: responseBody);
      } else if (response.statusCode == 500) {
        throw ApiException(HttpStatusCode.internalServerError,
            responseBody: responseBody);
      } else if (response.statusCode == 503) {
        throw ApiException(HttpStatusCode.serviceUnavailable,
            responseBody: responseBody);
      } else if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(HttpStatusCode.otherError,
            responseBody: responseBody);
      }

      return responseBody;
    } catch (e) {
      rethrow;
    } finally {
      _clientPresenter.close();
    }
  }
}
