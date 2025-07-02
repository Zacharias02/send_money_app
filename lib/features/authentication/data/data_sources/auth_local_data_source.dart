import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/core/services/local_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthSession({required bool isAuthenticated});

  Future<bool> getAuthSession();

  Future<void> deleteAuthSession();
}

@Injectable(as: AuthLocalDataSource)
@lazySingleton
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._localStorage);

  final LocalStorageService _localStorage;

  @override
  Future<void> saveAuthSession({required bool isAuthenticated}) async {
    try {
      await _localStorage.writeData(isAuthenticated.toString());
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<bool> getAuthSession() async {
    try {
      final rawData = await _localStorage.getData(AppConstants.kAuthLoginKey);
      return rawData == 'true';
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<void> deleteAuthSession() async {
    try {
      await _localStorage.deleteData(AppConstants.kAuthLoginKey);
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }
}
