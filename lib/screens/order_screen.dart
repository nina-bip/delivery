import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/branch.dart';
import '../models/order.dart';
import '../services/branch_service.dart';
import '../services/cart_controller.dart';
import '../services/order_service.dart';
import '../theme/app_colors.dart';
import '../utils/format.dart';
import '../widgets/custom_button.dart';
import '../widgets/order_summary.dart';
import 'confirmation_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();
  final _branches = const BranchService();

  String? _wilayaId;
  String? _branchId;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _notes.dispose();
    super.dispose();
  }

  List<Branch> get _wilayaBranches {
    final id = _wilayaId;
    if (id == null) return const [];
    return _branches.branchesForWilaya(id);
  }

  bool get _needsBranchPicker => _wilayaBranches.length > 1;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_wilayaId == null) return;
    if (_needsBranchPicker && _branchId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a branch.')),
      );
      return;
    }

    setState(() => _busy = true);
    try {
      final receipt = await context.read<CartController>().submit(
        customer: CustomerInfo(
          fullName: _name.text.trim(),
          phone: _phone.text.trim(),
          address: _address.text.trim(),
          notes: _notes.text.trim(),
        ),
        wilayaId: _wilayaId!,
        branchId: _branchId,
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => ConfirmationScreen(receipt: receipt),
        ),
        (route) => route.isFirst,
      );
    } on OrderException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    final wilayas = _branches.wilayas();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'YOUR DETAILS',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.4),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          OrderSummary(
            items: cart.foodLines,
            extras: cart.extraLines,
            totalDa: cart.totalDa,
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Full Name'),
                TextFormField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  validator: (v) {
                    if ((v ?? '').trim().length < 2) {
                      return 'Enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                _label('Phone Number'),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (!isAlgerianPhone(v ?? '')) {
                      return 'Enter a valid Algerian mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                _label('Wilaya'),
                DropdownButtonFormField<String>(
                  key: ValueKey('wilaya-$_wilayaId'),
                  initialValue: _wilayaId,
                  hint: const Text('Select Wilaya'),
                  items: [
                    for (final w in wilayas)
                      DropdownMenuItem(value: w.id, child: Text(w.name)),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _wilayaId = value;
                      _branchId = null;
                    });
                  },
                  validator: (v) => v == null ? 'Select your Wilaya' : null,
                ),
                if (_needsBranchPicker) ...[
                  const SizedBox(height: 14),
                  _label('Branch'),
                  DropdownButtonFormField<String>(
                    key: ValueKey('branch-$_wilayaId-$_branchId'),
                    initialValue: _branchId,
                    hint: const Text('Select branch'),
                    items: [
                      for (final b in _wilayaBranches)
                        DropdownMenuItem(value: b.id, child: Text(b.name)),
                    ],
                    onChanged: (value) => setState(() => _branchId = value),
                    validator: (v) =>
                        _needsBranchPicker && v == null ? 'Select a branch' : null,
                  ),
                ] else if (_wilayaBranches.length == 1) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Order will go to ${_wilayaBranches.first.name}.',
                    style: const TextStyle(color: AppColors.muted, fontSize: 13),
                  ),
                ],
                const SizedBox(height: 14),
                _label('Address / Location'),
                TextFormField(
                  controller: _address,
                  maxLines: 2,
                  validator: (v) {
                    if ((v ?? '').trim().length < 4) {
                      return 'Enter your delivery address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                _label('Additional Notes (optional)'),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'No spicy sauce, call before delivery…',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            label: 'SUBMIT ORDER',
            busy: _busy,
            onPressed: cart.isEmpty || _busy ? null : _submit,
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.muted,
          fontSize: 13,
        ),
      ),
    );
  }
}
