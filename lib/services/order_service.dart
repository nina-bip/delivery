import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/order.dart';
import 'branch_service.dart';

class OrderException implements Exception {
  const OrderException(this.message);
  final String message;

  @override
  String toString() => message;
}

class OrderService {
  OrderService({BranchService? branchService, http.Client? client})
    : _branches = branchService ?? const BranchService(),
      _client = client ?? http.Client();

  final BranchService _branches;
  final http.Client _client;

  Future<OrderReceipt> submit(OrderDraft draft) async {
    final branch = _branches.resolve(
      wilayaId: draft.wilayaId,
      branchId: draft.branchId,
    );
    if (branch == null) {
      throw const OrderException(
        'Could not determine a Tasty Crusty branch for this Wilaya.',
      );
    }

    if (AppConfig.hasRemoteBackend) {
      return _submitRemote(draft, branch.name, branch.wilayaName);
    }
    return _submitLocal(branch.name, branch.wilayaName);
  }

  Future<OrderReceipt> _submitRemote(
    OrderDraft draft,
    String branchName,
    String wilayaName,
  ) async {
    final uri = Uri.parse('${AppConfig.backendUrl}/submitOrder');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(draft.toJson()),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const OrderException(
        'The restaurant could not receive your order. Please try again.',
      );
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return OrderReceipt(
      orderId: body['orderId'] as String? ?? _newOrderId(),
      branchName: body['branchName'] as String? ?? branchName,
      wilayaName: body['wilayaName'] as String? ?? wilayaName,
      createdAt: DateTime.now(),
    );
  }

  Future<OrderReceipt> _submitLocal(String branchName, String wilayaName) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    return OrderReceipt(
      orderId: _newOrderId(),
      branchName: branchName,
      wilayaName: wilayaName,
      createdAt: DateTime.now(),
    );
  }

  String _newOrderId() {
    final n = 1000 + Random().nextInt(9000);
    return 'TC-$n';
  }
}
