import 'package:injectable/injectable.dart';

@lazySingleton
class AppEnvironment {
  static const String restApiToken = String.fromEnvironment(
    'REST_API_KEY',
  );
  static const String localAuthLoginKey = String.fromEnvironment(
    'LOCAL_AUTH_LOGIN_KEY',
  );
}
