import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/menu_data.dart';
import '../models/extra.dart';
import '../models/food_item.dart';
import '../services/cart_controller.dart';
import '../theme/app_colors.dart';
import '../utils/format.dart';
import '../widgets/custom_button.dart';
import '../widgets/extra_card.dart';
import '../widgets/food_card.dart';
import '../widgets/quantity_selector.dart';
import 'order_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Future<void> _addFood(BuildContext context, FoodItem item) async {
    final qty = await showQuantitySheet(context, title: item.name);
    if (qty == null || !context.mounted) return;
    context.read<CartController>().addFood(item, qty);
  }

  Future<void> _addExtra(BuildContext context, Extra extra) async {
    final qty = await showQuantitySheet(context, title: extra.name);
    if (qty == null || !context.mounted) return;
    context.read<CartController>().addExtra(extra, qty);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENU',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
        children: [
          const Text(
            'Build your order. Add as many items as you like.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 16),
          for (final item in MenuData.items) ...[
            FoodCard(item: item, onAdd: () => _addFood(context, item)),
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 8),
          const Text(
            'EXTRAS',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          for (final extra in MenuData.extras) ...[
            ExtraCard(extra: extra, onAdd: () => _addExtra(context, extra)),
            const SizedBox(height: 10),
          ],
        ],
      ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.line)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${cart.itemCount} item${cart.itemCount == 1 ? '' : 's'}',
                          style: const TextStyle(color: AppColors.muted),
                        ),
                        const Spacer(),
                        Text(
                          formatDa(cart.totalDa),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.orangeSoft,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      label: 'ORDER NOW',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const OrderScreen(),
                          ),
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
