import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/core/presentation/widgets/app_button.dart';
import 'package:send_money_app/core/presentation/widgets/app_error_dialog.dart';
import 'package:send_money_app/core/presentation/widgets/app_text_field.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/wallet/wallet_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _cubit = getIt<AuthCubit>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await _cubit.signIn(_emailController.text, _passwordController.text);
    }
  }

  void _processError(String errorMessage) {
    _passwordController.clear();

    showDialog(
      context: context,
      builder: (_) {
        return AppErrorDialog(
          errorMessage: errorMessage,
          onClose: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isFailed) _processError(state.errorMessage!);

        if (state.isSuccessful && state.isAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => WalletScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            spacing: 10,
            children: [
              AppTextField(
                controller: _emailController,
                hintText: 'Enter email address',
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Email address is required.';
                  }

                  if (value != null &&
                      value.isNotEmpty &&
                      !AppConstants.emailRegex.hasMatch(value)) {
                    return 'Invalid email address format.';
                  }

                  return null;
                },
              ),
              AppTextField.password(
                controller: _passwordController,
                hintText: 'Enter password',
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Password is required.';
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AppButton(
                  isLoading: state.isLoading,
                  title: 'Sign In',
                  onPressed: _onSubmit,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
