import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';

void main() {
  group('WalletResponseModel', () {
    test('fromJson should correctly deserialize JSON into model', () {
      final model = WalletResponseModel.fromJson({
        'id': 'abc123',
        'amount': 1500.0,
        'createdAt': '2024-01-01T10:00:00.000Z',
        'updatedAt': '2024-01-02T12:00:00.000Z',
      });

      expect(model.id, 'abc123');
      expect(model.amount, 1500.0);
      expect(model.createdAt, DateTime.parse('2024-01-01T10:00:00.000Z'));
      expect(model.updatedAt, DateTime.parse('2024-01-02T12:00:00.000Z'));
    });

    test('toJson should convert model back to valid JSON map', () {
      final model = WalletResponseModel(
        id: 'abc123',
        amount: 1500.0,
        createdAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-02T12:00:00.000Z'),
      );

      final json = model.toJson();

      expect(json['id'], 'abc123');
      expect(json['amount'], 1500.0);
      expect(json['createdAt'], '2024-01-01T10:00:00.000Z');
      expect(json['updatedAt'], '2024-01-02T12:00:00.000Z');
    });

    test('toEntity should convert model to WalletEntity correctly', () {
      final model = WalletResponseModel(
        id: 'abc123',
        amount: 1500.0,
        createdAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-02T12:00:00.000Z'),
      );

      final entity = model.toEntity();

      expect(entity, isA<WalletEntity>());
      expect(entity.id, model.id);
      expect(entity.amount, model.amount);
      expect(entity.createdAt, model.createdAt);
      expect(entity.updatedAt, model.updatedAt);
    });
  });
}
