import 'package:flutter/material.dart';

import '../models/extra.dart';
import '../theme/app_colors.dart';
import '../utils/format.dart';

class ExtraCard extends StatelessWidget {
  const ExtraCard({super.key, required this.extra, required this.onAdd});

  final Extra extra;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              extra.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ),
          Text(
            formatDa(extra.priceDa),
            style: const TextStyle(
              color: AppColors.orangeSoft,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: AppColors.cardElevated,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  'ADD',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
