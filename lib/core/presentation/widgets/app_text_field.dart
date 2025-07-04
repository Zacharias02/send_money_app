import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/common/app_theme.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.isPassword = false,
    this.inputFormatters,
    this.textInputType,
    this.prefix,
  });

  factory AppTextField.password({
    required TextEditingController controller,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return AppTextField(
      isPassword: true,
      controller: controller,
      hintText: hintText,
      validator: validator,
    );
  }

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Widget? prefix;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  var _isObscured = false;

  void _showOrHidePassword() {
    setState(() => _isObscured = !_isObscured);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: AppTheme.kBlackColor,
      ),
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.textInputType,
      obscureText: _isObscured,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.kMutedColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: AppTheme.kMutedTextColor,
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: AppTheme.kErrorColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.kMutedColor),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.kTealAccentColor),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.kErrorColor),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.kErrorColor),
          borderRadius: BorderRadius.circular(20),
        ),
        prefix: widget.prefix,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: _showOrHidePassword,
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: AppTheme.kTealAccentColor,
                ),
              )
            : null,
      ),
    );
  }
}
