import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme/app_colors.dart';

class FoodIllustration extends StatelessWidget {
  const FoodIllustration({
    super.key,
    required this.visual,
    this.height = 160,
  });

  final FoodVisual visual;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = switch (visual) {
      FoodVisual.spicy => const [Color(0xFF7A1208), Color(0xFFE53935)],
      FoodVisual.sweet => const [Color(0xFF7A3A00), Color(0xFFFF8A3D)],
      FoodVisual.classic => const [Color(0xFF3D2A14), Color(0xFFC47A2C)],
      FoodVisual.cheese => const [Color(0xFF6B4A00), Color(0xFFFFC107)],
      FoodVisual.mix => const [Color(0xFF5A0A12), Color(0xFFFF6A00)],
      FoodVisual.tenders => const [Color(0xFF4A2C0A), Color(0xFFD4A017)],
    };
    final icon = switch (visual) {
      FoodVisual.spicy => Icons.local_fire_department_rounded,
      FoodVisual.sweet => Icons.icecream_rounded,
      FoodVisual.classic => Icons.lunch_dining_rounded,
      FoodVisual.cheese => Icons.egg_alt_rounded,
      FoodVisual.mix => Icons.restaurant_rounded,
      FoodVisual.tenders => Icons.kebab_dining_rounded,
    };

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            bottom: -28,
            child: Icon(
              icon,
              size: height * 1.15,
              color: Colors.black.withValues(alpha: 0.22),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.28),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: height * 0.38, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
