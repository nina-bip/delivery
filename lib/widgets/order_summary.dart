import 'package:flutter/material.dart';

import '../models/cart_line.dart';
import '../theme/app_colors.dart';
import '../utils/format.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.items,
    required this.extras,
    required this.totalDa,
  });

  final List<CartLine> items;
  final List<CartLine> extras;
  final int totalDa;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR ORDER',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
          if (items.isEmpty && extras.isEmpty)
            const Text(
              'No items yet.',
              style: TextStyle(color: AppColors.muted),
            ),
          ...items.map(_line),
          if (extras.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              'Extras',
              style: TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            ...extras.map(_line),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.line),
          ),
          Row(
            children: [
              const Text(
                'TOTAL',
                style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1),
              ),
              const Spacer(),
              Text(
                formatDa(totalDa),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: AppColors.orangeSoft,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _line(CartLine line) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${line.quantity} × ${line.name}',
              style: const TextStyle(height: 1.3),
            ),
          ),
          Text(
            formatDa(line.lineTotalDa),
            style: const TextStyle(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
