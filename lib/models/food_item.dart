class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.priceDa,
    required this.visual,
    this.promoTag,
  });

  final String id;
  final String name;
  final String description;
  final int priceDa;
  final FoodVisual visual;
  final String? promoTag;
}

enum FoodVisual { spicy, sweet, classic, cheese, mix, tenders }
