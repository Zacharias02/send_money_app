import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/splash/presentation/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>()..checkSession(),
      child: MaterialApp(
        title: 'Send Money App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
