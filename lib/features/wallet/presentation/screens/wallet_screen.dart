import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/core/presentation/widgets/app_button.dart';
import 'package:send_money_app/core/presentation/widgets/app_scaffold.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:send_money_app/features/wallet/presentation/screens/send_money_screen.dart';
import 'package:send_money_app/features/wallet/presentation/screens/transaction_history_screen.dart';
import 'package:send_money_app/features/wallet/presentation/widgets/balance_section.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isSuccessful && !state.isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome back! 👋',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => getIt<AuthCubit>().signOut(),
                        icon: Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: BalanceSection(),
                ),
                AppButton(
                  title: 'Send Money',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendMoneyScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                AppButton(
                  title: 'View Transactions',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionHistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
