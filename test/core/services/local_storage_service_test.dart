import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/services/local_storage_service.dart';

import 'package:send_money_app/core/common/app_constants.dart';

import '../../mocks/core_mock.mocks.dart';

void main() {
  late MockFlutterSecureStorage mockStorage;
  late LocalStorageService storageService;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    storageService = LocalStorageService(mockStorage);
  });

  group('LocalStorageService', () {
    test('writeData stores value', () async {
      await storageService.writeData('test_token');

      verify(
        mockStorage.write(
          key: AppConstants.kAuthLoginKey,
          value: 'test_token',
        ),
      ).called(1);
    });

    test('getData returns stored value', () async {
      when(
        mockStorage.read(key: 'sample_key'),
      ).thenAnswer((_) async => 'sample_value');

      final result = await storageService.getData('sample_key');

      expect(result, 'sample_value');
      verify(mockStorage.read(key: 'sample_key')).called(1);
    });

    test('deleteData deletes the key', () async {
      await storageService.deleteData('sample_key');

      verify(mockStorage.delete(key: 'sample_key')).called(1);
    });
  });
}
