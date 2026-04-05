import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/gap.dart';

/// Title row for registration flows. [showBack] false on step 1 only.
class RegistrationStepHeader extends StatelessWidget {
  const RegistrationStepHeader({
    super.key,
    this.showBack = true,
    this.onBack,
    this.titleFontSize = 20,
  });

  final bool showBack;
  final VoidCallback? onBack;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        gap(width: 20),
        if (showBack)
          InkWell(
            onTap: onBack ?? () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
          )
        else
          const SizedBox(width: 28),
        Text(
          'تسجيل الطالب',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
