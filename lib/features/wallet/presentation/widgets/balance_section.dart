import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceSection extends StatefulWidget {
  const BalanceSection({super.key});

  @override
  State<BalanceSection> createState() => _BalanceSectionState();
}

class _BalanceSectionState extends State<BalanceSection> {
  final _amount = "₱ 200,000.00";
  var _isMasked = true;

  String get displayAmount {
    if (_isMasked) {
      return _amount.replaceAll(RegExp(r'\d'), '*');
    } else {
      return _amount;
    }
  }

  void _onMaskChanged() {
    setState(() {
      _isMasked = !_isMasked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 6,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                key: const Key('balance_text'),
                displayAmount,
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                key: const Key('toggle_button'),
                icon: Icon(
                  _isMasked ? Icons.visibility_off : Icons.visibility,
                  size: 24,
                ),
                onPressed: _onMaskChanged,
              ),
            ],
          ),
          Text(
            'Current Wallet Balance',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
