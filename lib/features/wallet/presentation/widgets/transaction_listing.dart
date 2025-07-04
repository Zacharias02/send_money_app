import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';

class TransactionListing extends StatelessWidget {
  const TransactionListing({
    super.key,
    required this.transactions,
  });

  final List<WalletEntity> transactions;

  String _formatDate(String date) {
    return DateFormat(
      'MMMM dd, yyyy hh:mm a',
    ).format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(
            '₱ ${transaction.amount?.toStringAsFixed(2) ?? '0.00'}',
            style: GoogleFonts.poppins(),
          ),
          subtitle: Text(
            _formatDate(
              transaction.createdAt?.toIso8601String() ??
                  DateTime.now().toIso8601String(),
            ),
            style: GoogleFonts.poppins(),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
