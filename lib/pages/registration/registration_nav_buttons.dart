import 'package:flutter/material.dart';
import 'package:madrasati_plus/colors.dart';

/// Equal-width back + next row (RTL-friendly). Same height and spacing on every step.
class RegistrationNavButtons extends StatelessWidget {
  RegistrationNavButtons({
    super.key,
    required this.onNext,
    required this.nextLabel,
    VoidCallback? onBack,
    this.backLabel = 'رجوع',
  }) : onBack = onBack;

  final VoidCallback? onBack;
  final String backLabel;
  final VoidCallback onNext;
  final String nextLabel;

  static const double height = 52;
  static const double gap = 16;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: blue,
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size(0, height),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    if (onBack == null) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          style: style,
          onPressed: onNext,
          child: Text(nextLabel, style: textStyle),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: height,
            child: ElevatedButton(
              style: style,
              onPressed: onBack,
              child: Text(backLabel, style: textStyle),
            ),
          ),
        ),
        const SizedBox(width: gap),
        Expanded(
          child: SizedBox(
            height: height,
            child: ElevatedButton(
              style: style,
              onPressed: onNext,
              child: Text(nextLabel, style: textStyle),
            ),
          ),
        ),
      ],
    );
  }
}
