import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/presentation/widgets/app_progress_indicator.dart';
import 'package:send_money_app/core/common/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.isDisabled = false,
    this.isLoading = false,
    this.onPressed,
  });

  final String title;
  final bool isDisabled;
  final bool isLoading;
  final VoidCallback? onPressed;

  bool get _isDisabled => isDisabled || onPressed == null || isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isDisabled ? null : onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(0),
        minimumSize: WidgetStateProperty.all<Size>(
          Size(double.infinity, 45),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (_isDisabled) return AppTheme.kMutedColor;

          return AppTheme.kTealAccentColor;
        }),
      ),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) AppProgressIndicator(size: 15),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: _isDisabled
                  ? AppTheme.kMutedTextColor
                  : AppTheme.kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
