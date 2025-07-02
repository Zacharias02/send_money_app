import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/app_constants.dart';

@lazySingleton
class LocalStorageService {
  const LocalStorageService(this._storage);

  final FlutterSecureStorage _storage;

  // Store values to local storage
  Future<void> writeData(String value) async {
    await _storage.write(key: AppConstants.kAuthLoginKey, value: value);
  }

  // Get store values from local by
  // providing a key pair
  Future<String?> getData(String key) async {
    return await _storage.read(key: key);
  }

  // Get store values from local by
  // providing a key pair
  Future<void> deleteData(String key) async {
    return await _storage.delete(key: key);
  }
}
