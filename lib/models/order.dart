import 'cart_line.dart';

class CustomerInfo {
  const CustomerInfo({
    required this.fullName,
    required this.phone,
    required this.address,
    this.notes = '',
  });

  final String fullName;
  final String phone;
  final String address;
  final String notes;

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'phone': phone,
    'address': address,
    'notes': notes,
  };
}

class OrderDraft {
  const OrderDraft({
    required this.wilayaId,
    required this.branchId,
    required this.customer,
    required this.items,
    required this.extras,
    required this.totalDa,
  });

  final String wilayaId;
  final String branchId;
  final CustomerInfo customer;
  final List<CartLine> items;
  final List<CartLine> extras;
  final int totalDa;

  Map<String, dynamic> toJson() => {
    'wilayaId': wilayaId,
    'branchId': branchId,
    'customer': customer.toJson(),
    'items': [
      for (final line in items)
        {
          'id': line.productId,
          'name': line.name,
          'quantity': line.quantity,
          'unitPriceDa': line.unitPriceDa,
          'lineTotalDa': line.lineTotalDa,
        },
    ],
    'extras': [
      for (final line in extras)
        {
          'id': line.productId,
          'name': line.name,
          'quantity': line.quantity,
          'unitPriceDa': line.unitPriceDa,
          'lineTotalDa': line.lineTotalDa,
        },
    ],
    'totalDa': totalDa,
  };
}

class OrderReceipt {
  const OrderReceipt({
    required this.orderId,
    required this.branchName,
    required this.wilayaName,
    required this.createdAt,
  });

  final String orderId;
  final String branchName;
  final String wilayaName;
  final DateTime createdAt;
}
