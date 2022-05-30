import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RestApiClientPresenter extends http.BaseClient {
  final http.Client _inner;
  RestApiClientPresenter() : this.di(http.Client());

  @visibleForTesting
  RestApiClientPresenter.di(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Content-type'] = "application/json";
    request.headers['Accept'] = "application/json";
    // Defined when setting Authorization
    //request.headers['Authorization'] = ~~~;

    return _inner.send(request);
  }
}
