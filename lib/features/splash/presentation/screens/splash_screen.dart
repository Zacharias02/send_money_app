import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/core/presentation/widgets/app_logo.dart';
import 'package:send_money_app/core/presentation/widgets/app_progress_indicator.dart';
import 'package:send_money_app/core/presentation/widgets/app_scaffold.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:send_money_app/features/wallet/wallet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => state.isAuthenticated
                ? const WalletScreen()
                : const LoginScreen(),
          ),
        );
      },
      child: AppScaffold(
        body: Center(
          child: Column(
            spacing: 18,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(),
              AppProgressIndicator(size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
