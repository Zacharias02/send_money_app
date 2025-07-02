import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/features/authentication/data/data_sources/auth_local_data_source.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockLocalStorageService mockStorage;
  late AuthLocalDataSourceImpl dataSource;

  setUp(() {
    mockStorage = MockLocalStorageService();
    dataSource = AuthLocalDataSourceImpl(mockStorage);
  });

  group('AuthLocalDataSourceImpl', () {
    test('saveAuthSession stores true as "true"', () async {
      await dataSource.saveAuthSession(isAuthenticated: true);

      verify(mockStorage.writeData('true')).called(1);
    });

    test('saveAuthSession throws LocalStorageException on error', () async {
      when(mockStorage.writeData(any)).thenThrow(Exception('Storage error'));

      expect(
        () => dataSource.saveAuthSession(isAuthenticated: true),
        throwsA(isA<LocalStorageException>()),
      );
    });

    test('getAuthSession returns true when stored value is "true"', () async {
      when(
        mockStorage.getData(AppConstants.kAuthLoginKey),
      ).thenAnswer((_) async => 'true');

      final result = await dataSource.getAuthSession();

      expect(result, true);
    });

    test('getAuthSession returns false when stored value is "false"', () async {
      when(
        mockStorage.getData(AppConstants.kAuthLoginKey),
      ).thenAnswer((_) async => 'false');

      final result = await dataSource.getAuthSession();

      expect(result, false);
    });

    test('getAuthSession throws LocalStorageException on error', () async {
      when(mockStorage.getData(any)).thenThrow(Exception('Storage error'));

      expect(
        () => dataSource.getAuthSession(),
        throwsA(isA<LocalStorageException>()),
      );
    });

    test('deleteAuthSession calls deleteData with correct key', () async {
      await dataSource.deleteAuthSession();

      verify(mockStorage.deleteData(AppConstants.kAuthLoginKey)).called(1);
    });

    test('deleteAuthSession throws LocalStorageException on error', () async {
      when(mockStorage.deleteData(any)).thenThrow(Exception('Delete error'));

      expect(
        () => dataSource.deleteAuthSession(),
        throwsA(isA<LocalStorageException>()),
      );
    });
  });
}
