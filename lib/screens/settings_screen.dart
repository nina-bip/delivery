import 'package:flutter/material.dart';

import '../services/branch_service.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final branches = const BranchService().allBranches();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SETTINGS',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.6),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _card(
            title: 'Language',
            child: const Text(
              'English. More languages will be added later.',
              style: TextStyle(color: AppColors.muted, height: 1.4),
            ),
          ),
          _card(
            title: 'Contact',
            child: const Text(
              'After you place an order, the assigned branch will call you on the phone number you provide. No payment is taken in the app.',
              style: TextStyle(color: AppColors.muted, height: 1.4),
            ),
          ),
          _card(
            title: 'Restaurant information',
            child: const Text(
              'Tasty Crusty is a crispy-chicken restaurant with branches across Algeria. Browse the menu, build an order, and we handle confirmation by phone.',
              style: TextStyle(color: AppColors.muted, height: 1.4),
            ),
          ),
          _card(
            title: 'Opening hours',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final b in branches)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${b.name}: ${b.hours}',
                      style: const TextStyle(color: AppColors.muted, height: 1.4),
                    ),
                  ),
              ],
            ),
          ),
          _card(
            title: 'Locations / branches',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final b in branches)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      '${b.name}\n${b.address}',
                      style: const TextStyle(color: AppColors.muted, height: 1.35),
                    ),
                  ),
              ],
            ),
          ),
          _card(
            title: 'About',
            child: const Text(
              'Tasty Crusty ordering app — MVP. Online payment, accounts, and live tracking are planned for later versions.',
              style: TextStyle(color: AppColors.muted, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
