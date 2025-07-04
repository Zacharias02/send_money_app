import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/common/app_theme.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:send_money_app/core/presentation/widgets/app_button.dart';
import 'package:send_money_app/core/presentation/widgets/app_scaffold.dart';
import 'package:send_money_app/core/presentation/widgets/app_text_field.dart';
import 'package:send_money_app/features/wallet/presentation/cubits/wallet_cubit/wallet_cubit.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cubit = getIt<WalletCubit>();

  final _amountController = TextEditingController();

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await _cubit.sendMoney(_amountController.text);
    }
  }

  void _onListen(BuildContext context, WalletState state) {
    if (state.isSuccessful || state.isFailed) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AppBottomSheet(
            isSuccessful: state.isSuccessful,
            message: state.message!,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: AppScaffold(
        appBarTitle: 'Send Money',
        body: BlocConsumer<WalletCubit, WalletState>(
          listener: _onListen,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _amountController,
                        textInputType: TextInputType.number,
                        hintText: 'Enter amount to send',
                        prefix: Text(
                          '₱ ',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppTheme.kMutedTextColor,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Amount is required.';
                          }

                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: AppButton(
                          key: const Key('send_money_button'),
                          title: 'Send Money',
                          isLoading: state.isLoading,
                          onPressed: _onSubmit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
