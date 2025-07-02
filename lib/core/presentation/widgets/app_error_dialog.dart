import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/common/app_theme.dart';
import 'package:send_money_app/core/presentation/widgets/app_button.dart';

class AppErrorDialog extends StatelessWidget {
  const AppErrorDialog({
    super.key,
    required this.errorMessage,
    this.onClose,
  });

  final String errorMessage;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.kWhiteColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 250),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Icon(
                  Icons.warning,
                  size: 80,
                  color: AppTheme.kErrorColor,
                ),
                Text(
                  errorMessage,
                  style: GoogleFonts.poppins(fontSize: 15),
                ),

                if (onClose != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: AppButton(
                      title: 'Close',
                      onPressed: onClose,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
