import 'package:flutter_test/flutter_test.dart';
import 'package:thaisty_crousty/models/extra.dart';
import 'package:thaisty_crousty/models/food_item.dart';
import 'package:thaisty_crousty/models/order.dart';
import 'package:thaisty_crousty/services/branch_service.dart';
import 'package:thaisty_crousty/services/cart_controller.dart';
import 'package:thaisty_crousty/utils/format.dart';

void main() {
  test('single-branch Wilaya resolves automatically', () {
    final branch = const BranchService().resolve(wilayaId: 'constantine');
    expect(branch?.id, 'cst-01');
    expect(branch?.name, 'Constantine Branch');
  });

  test('multi-branch Wilaya requires an explicit branch id', () {
    const service = BranchService();
    expect(service.resolve(wilayaId: 'algiers'), isNull);
    expect(service.resolve(wilayaId: 'algiers', branchId: 'alg-02')?.cityLabel, 'Bab Ezzouar');
  });

  test('cart totals food and extras', () {
    final cart = CartController();
    cart.addFood(
      const FoodItem(
        id: 'a',
        name: 'Crousty Spicy',
        description: 'x',
        priceDa: 700,
        visual: FoodVisual.spicy,
      ),
      2,
    );
    cart.addExtra(const Extra(id: 'c', name: 'Cheese', priceDa: 100), 2);
    expect(cart.totalDa, 1600);
    expect(cart.itemCount, 4);
  });

  test('Algerian phone validation', () {
    expect(isAlgerianPhone('0551234567'), isTrue);
    expect(isAlgerianPhone('07 12 34 56 78'), isTrue);
    expect(isAlgerianPhone('123'), isFalse);
  });

  test('submit assigns branch without exposing email', () async {
    final cart = CartController();
    cart.addFood(
      const FoodItem(
        id: 'a',
        name: 'Crousty Sweet',
        description: 'x',
        priceDa: 700,
        visual: FoodVisual.sweet,
      ),
      1,
    );
    final receipt = await cart.submit(
      customer: const CustomerInfo(
        fullName: 'Ahmed Ben',
        phone: '0551234567',
        address: 'Cité des Frères',
      ),
      wilayaId: 'oran',
    );
    expect(receipt.orderId, startsWith('TC-'));
    expect(receipt.branchName, 'Oran Branch');
  });
}
