import 'package:flutter/foundation.dart';

import '../models/cart_line.dart';
import '../models/extra.dart';
import '../models/food_item.dart';
import '../models/order.dart';
import 'branch_service.dart';
import 'order_service.dart';

class CartController extends ChangeNotifier {
  CartController({
    OrderService? orderService,
    BranchService? branchService,
  }) : _orders = orderService ?? OrderService(),
       _branches = branchService ?? const BranchService();

  final OrderService _orders;
  final BranchService _branches;

  final Map<String, CartLine> _lines = {};

  List<CartLine> get foodLines =>
      _lines.values.where((l) => !l.isExtra).toList(growable: false);

  List<CartLine> get extraLines =>
      _lines.values.where((l) => l.isExtra).toList(growable: false);

  List<CartLine> get allLines => _lines.values.toList(growable: false);

  int get itemCount =>
      _lines.values.fold<int>(0, (sum, line) => sum + line.quantity);

  int get totalDa =>
      _lines.values.fold<int>(0, (sum, line) => sum + line.lineTotalDa);

  bool get isEmpty => _lines.isEmpty;

  void addFood(FoodItem item, int quantity) {
    _add(item.id, item.name, item.priceDa, quantity, isExtra: false);
  }

  void addExtra(Extra extra, int quantity) {
    _add(extra.id, extra.name, extra.priceDa, quantity, isExtra: true);
  }

  void _add(
    String id,
    String name,
    int price,
    int quantity, {
    required bool isExtra,
  }) {
    if (quantity < 1) return;
    final existing = _lines[id];
    if (existing == null) {
      _lines[id] = CartLine(
        productId: id,
        name: name,
        unitPriceDa: price,
        quantity: quantity,
        isExtra: isExtra,
      );
    } else {
      _lines[id] = existing.copyWith(quantity: existing.quantity + quantity);
    }
    notifyListeners();
  }

  void setQuantity(String productId, int quantity) {
    if (quantity < 1) {
      _lines.remove(productId);
    } else {
      final existing = _lines[productId];
      if (existing == null) return;
      _lines[productId] = existing.copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }

  Future<OrderReceipt> submit({
    required CustomerInfo customer,
    required String wilayaId,
    String? branchId,
  }) async {
    final branch = _branches.resolve(wilayaId: wilayaId, branchId: branchId);
    if (branch == null) {
      throw const OrderException(
        'Please select a branch for this Wilaya.',
      );
    }
    if (isEmpty) {
      throw const OrderException('Your order is empty.');
    }

    final draft = OrderDraft(
      wilayaId: wilayaId,
      branchId: branch.id,
      customer: customer,
      items: foodLines,
      extras: extraLines,
      totalDa: totalDa,
    );
    final receipt = await _orders.submit(draft);
    clear();
    return receipt;
  }
}
