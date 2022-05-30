import 'package:flutter_mobile_app_template/repository/environment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() async {
  setUp(() {
    resetMockitoState();
  });

  test('getOperationTypeString', () {
    final repository = EnvironmentRepository();
    expect(repository.getOperationTypeString() == '', isTrue);
  });
}
