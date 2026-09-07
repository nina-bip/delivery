class CartLine {
  const CartLine({
    required this.productId,
    required this.name,
    required this.unitPriceDa,
    required this.quantity,
    required this.isExtra,
  });

  final String productId;
  final String name;
  final int unitPriceDa;
  final int quantity;
  final bool isExtra;

  int get lineTotalDa => unitPriceDa * quantity;

  CartLine copyWith({int? quantity}) {
    return CartLine(
      productId: productId,
      name: name,
      unitPriceDa: unitPriceDa,
      quantity: quantity ?? this.quantity,
      isExtra: isExtra,
    );
  }
}
