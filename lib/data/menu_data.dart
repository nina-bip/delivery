import '../models/extra.dart';
import '../models/food_item.dart';

abstract final class MenuData {
  static const items = <FoodItem>[
    FoodItem(
      id: 'crousty-spicy',
      name: 'Crousty Spicy',
      description: 'Crispy chicken, hot sauce, pickles, toasted bun.',
      priceDa: 700,
      visual: FoodVisual.spicy,
      promoTag: 'Fan favorite',
    ),
    FoodItem(
      id: 'crousty-sweet',
      name: 'Crousty Sweet',
      description: 'Crispy chicken, sweet glaze, slaw, toasted bun.',
      priceDa: 700,
      visual: FoodVisual.sweet,
      promoTag: 'Sweet heat',
    ),
    FoodItem(
      id: 'crousty-classic',
      name: 'Crousty Classic',
      description: 'Golden chicken, house sauce, lettuce, tomato.',
      priceDa: 650,
      visual: FoodVisual.classic,
    ),
    FoodItem(
      id: 'crousty-cheese',
      name: 'Crousty Cheese',
      description: 'Double melt, crispy chicken, creamy sauce.',
      priceDa: 750,
      visual: FoodVisual.cheese,
    ),
    FoodItem(
      id: 'crousty-mix',
      name: 'Crousty Mix',
      description: 'Spicy + sweet stacked. For when one sauce is not enough.',
      priceDa: 850,
      visual: FoodVisual.mix,
      promoTag: 'Loaded',
    ),
    FoodItem(
      id: 'chicken-tenders',
      name: 'Chicken Tenders',
      description: 'Crispy strips with dipping sauce on the side.',
      priceDa: 500,
      visual: FoodVisual.tenders,
    ),
  ];

  static const extras = <Extra>[
    Extra(id: 'extra-cheese', name: 'Cheese', priceDa: 100),
    Extra(id: 'extra-sauce', name: 'Sauce', priceDa: 50),
    Extra(id: 'extra-fries', name: 'Fries', priceDa: 150),
    Extra(id: 'extra-drink', name: 'Drink', priceDa: 120),
  ];
}
