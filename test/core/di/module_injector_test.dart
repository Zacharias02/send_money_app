import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/core/di/injector.dart';

void main() {
  late FlutterSecureStorage secureStorage;

  setUp(() {
    // Initialize GetIt before each test
    configureDependencies();

    // Retrieve the dependencies we need for testing\
    secureStorage = getIt.get<FlutterSecureStorage>();
  });

  group('InjectableModule', () {
    test('should return an instance of injectable dependencies', () {
      // Assert
      expect(secureStorage, isA<FlutterSecureStorage>());
    });
  });
}
