import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';

void main() {
  test('should convert WalletEntity to WalletResponseModel correctly', () {
    final now = DateTime.now();
    final entity = WalletEntity(
      id: '123',
      amount: 999.99,
      createdAt: now,
      updatedAt: now,
    );

    final model = entity.toModel();

    expect(model.id, entity.id);
    expect(model.amount, entity.amount);
    expect(model.createdAt, entity.createdAt);
    expect(model.updatedAt, entity.updatedAt);
  });
}
