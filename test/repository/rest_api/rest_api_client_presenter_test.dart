import 'package:flutter_mobile_app_template/repository/rest_api/rest_api_client_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rest_api_client_presenter_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<http.Client>(returnNullOnMissingStub: true),
  MockSpec<http.BaseRequest>(returnNullOnMissingStub: true),
  MockSpec<http.StreamedResponse>(returnNullOnMissingStub: true),
])
void main() {
  setUp(() {
    resetMockitoState();
  });

  test('send', () async {
    final response = MockStreamedResponse();
    final httpClient = MockClient();
    when(httpClient.send(any)).thenAnswer((realInvocation) {
      final args = realInvocation.positionalArguments;

      http.BaseRequest request = args[0];
      expect(request.headers.containsKey('Content-type'), isTrue);
      expect(request.headers['Content-type'] == 'application/json', isTrue);
      expect(request.headers.containsKey('Accept'), isTrue);
      expect(request.headers['Accept'] == 'application/json', isTrue);
      return Future.value(response);
    });

    final mockRequest = MockBaseRequest();
    when(mockRequest.headers).thenReturn({});

    final useCase = RestApiClientPresenter.di(httpClient);
    await useCase.send(mockRequest);
  });
}
