import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/application/config/app_environment.dart';

@module
abstract class ModuleInjector {
  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();

  @lazySingleton
  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://crudcrud.com/api/${AppEnvironment.restApiToken}',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}
