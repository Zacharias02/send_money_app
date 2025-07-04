import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/common/app_theme.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.message,
    this.isSuccessful = true,
  });

  final String message;
  final bool isSuccessful;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 7,
          children: <Widget>[
            Icon(
              isSuccessful ? Icons.check : Icons.close,
              size: 50,
              color: isSuccessful
                  ? AppTheme.kSuccessColor
                  : AppTheme.kErrorColor,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
