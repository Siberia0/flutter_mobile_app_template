import 'package:flutter_mobile_app_template/exception/api_exception.dart';
import 'package:flutter_mobile_app_template/repository/rest_api/rest_api_client_presenter.dart';
import 'package:flutter_mobile_app_template/repository/rest_api/rest_api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rest_api_repository_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<RestApiClientPresenter>(returnNullOnMissingStub: true),
  MockSpec<Response>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  test('close', () {
    final presenter = MockRestApiClientPresenter();

    final repository = RestApiRepository.di(presenter);
    expect(() => repository.close(), returnsNormally);
  });

  group('request', () {
    test('get', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn('''
      {'result': true}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      try {
        final result = await repository.request(
            url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60);
        expect(result.containsKey('result'), isTrue);
        expect(result['result'] == true, isTrue);
      } catch (e) {
        // Verify that exceptions are not thrown
        expect(true, isTrue);
      }
      expect(() => repository.close(), returnsNormally);
    });

    test('put', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn('''
      {'result': true}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.put(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      try {
        final result = await repository.request(
            url: 'https://test',
            method: HttpMethod.put,
            timeOutSeconds: 60,
            body: {'key', 'value'});
        expect(result.containsKey('result'), isTrue);
        expect(result['result'] == true, isTrue);
      } catch (e) {
        // Verify that exceptions are not thrown
        expect(true, isTrue);
      }
      expect(() => repository.close(), returnsNormally);
    });

    test('patch', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn('''
      {'result': true}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.patch(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      try {
        final result = await repository.request(
            url: 'https://test',
            method: HttpMethod.patch,
            timeOutSeconds: 60,
            body: {'key', 'value'});
        expect(result.containsKey('result'), isTrue);
        expect(result['result'] == true, isTrue);
      } catch (e) {
        // Verify that exceptions are not thrown
        expect(true, isTrue);
      }
      expect(() => repository.close(), returnsNormally);
    });

    test('post', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn('''
      {'result': true}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.post(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      try {
        final result = await repository.request(
            url: 'https://test',
            method: HttpMethod.post,
            timeOutSeconds: 60,
            body: {'key', 'value'});
        expect(result.containsKey('result'), isTrue);
        expect(result['result'] == true, isTrue);
      } catch (e) {
        // Verify that exceptions are not thrown
        expect(true, isTrue);
      }
      expect(() => repository.close(), returnsNormally);
    });

    test('delete', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn('''
      {'result': true}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.delete(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      try {
        final result = await repository.request(
            url: 'https://test',
            method: HttpMethod.delete,
            timeOutSeconds: 60,
            body: {'key', 'value'});
        expect(result.containsKey('result'), isTrue);
        expect(result['result'] == true, isTrue);
      } catch (e) {
        // Verify that exceptions are not thrown
        expect(true, isTrue);
      }
      expect(() => repository.close(), returnsNormally);
    });

    test('empty key name list', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn('''
      [{'result': true}]
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      try {
        final result = await repository.request(
            url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60);
        expect(result.containsKey(RestApiRepository.emptyKeyName), isTrue);
        expect(
            result[RestApiRepository.emptyKeyName].first.containsKey('result'),
            isTrue);
        expect(result[RestApiRepository.emptyKeyName].first['result'] == true,
            isTrue);
      } catch (e) {
        // Verify that exceptions are not thrown
        expect(true, isTrue);
      }
      expect(() => repository.close(), returnsNormally);
    });

    test('excepton occured', () async {
      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any)).thenThrow(Exception());

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) => e is Exception)));
    });
  });

  group('request: status error', () {
    test('400', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(400);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException && e.statusCode == HttpStatusCode.badRequest)));
    });

    test('401', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(401);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException &&
              e.statusCode == HttpStatusCode.unAuthorized)));
    });

    test('403', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(403);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException && e.statusCode == HttpStatusCode.forbidden)));
    });

    test('404', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(404);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException && e.statusCode == HttpStatusCode.notFound)));
    });

    test('409', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(409);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException && e.statusCode == HttpStatusCode.conflict)));
    });

    test('413', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(413);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException &&
              e.statusCode == HttpStatusCode.requestTooLargeForGateway)));
    });

    test('500', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(500);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException &&
              e.statusCode == HttpStatusCode.internalServerError)));
    });

    test('503', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(503);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException &&
              e.statusCode == HttpStatusCode.serviceUnavailable)));
    });

    test('100', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(100);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException && e.statusCode == HttpStatusCode.otherError)));
    });

    test('300', () async {
      final response = MockResponse();
      when(response.statusCode).thenReturn(300);
      when(response.body).thenReturn('''
      {}
      ''');

      final presenter = MockRestApiClientPresenter();
      when(presenter.get(any))
          .thenAnswer((realInvocation) => Future.value(response));

      final repository = RestApiRepository.di(presenter);
      expect(
          () async => await repository.request(
              url: 'https://test', method: HttpMethod.get, timeOutSeconds: 60),
          throwsA(predicate((e) =>
              e is ApiException && e.statusCode == HttpStatusCode.otherError)));
    });
  });
}
