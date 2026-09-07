import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TastyLogo extends StatelessWidget {
  const TastyLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'TASTY CRUSTY',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: compact ? 2.4 : 3.6,
            fontSize: compact ? 18 : 28,
            height: 1,
          ),
        ),
        SizedBox(height: compact ? 3 : 6),
        Container(
          height: 3,
          width: compact ? 72 : 112,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            gradient: const LinearGradient(
              colors: [AppColors.red, AppColors.orange],
            ),
          ),
        ),
      ],
    );
  }
}
