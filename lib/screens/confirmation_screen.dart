import 'package:flutter/material.dart';

import '../models/order.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/tasty_logo.dart';
import 'home_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key, required this.receipt});

  final OrderReceipt receipt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            children: [
              const TastyLogo(compact: true),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.line),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.orange,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ORDER RECEIVED',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.8,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Thank you for your order.',
                      style: TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Order #${receipt.orderId}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppColors.orangeSoft,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'The ${receipt.branchName} will contact you shortly.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(height: 1.4, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                label: 'BACK TO HOME',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (_) => const HomeScreen(),
                    ),
                    (_) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
