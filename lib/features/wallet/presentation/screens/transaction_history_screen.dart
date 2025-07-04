import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/common/app_theme.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/core/presentation/widgets/app_progress_indicator.dart';
import 'package:send_money_app/core/presentation/widgets/app_scaffold.dart';
import 'package:send_money_app/features/wallet/presentation/cubits/wallet_cubit/wallet_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/widgets/transaction_listing.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final _cubit = getIt<WalletCubit>();

  @override
  void initState() {
    _cubit.getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: AppScaffold(
        appBarTitle: 'Transaction History',
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: AppProgressIndicator());
            }

            if (state.isFailed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.close,
                      size: 50,
                      color: AppTheme.kErrorColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.message ?? AppConstants.kUnknownError,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            if (state.isSuccessful) {
              final transactions = state.transactions ?? [];

              if (transactions.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sentiment_dissatisfied, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        AppConstants.kNoRecordsFound,
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }

              return TransactionListing(transactions: transactions);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
