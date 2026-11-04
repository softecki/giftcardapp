import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/core/gift_card_payment.dart';
import 'package:malipo_agent/models/business_model.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';
import 'payment_screen.dart';

class BusinessDetailScreen extends StatefulWidget {
  const BusinessDetailScreen({super.key, required this.businessId});

  final int businessId;

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  final _api = GiftCardApiService();
  BusinessModel? _business;
  List<double> _denoms = [];
  double? _selected;
  bool _loading = true;
  bool _buying = false;
  String _payment = 'wallet';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final res = await _api.getBusinessDetails(widget.businessId);
      final raw = res['data']?['business'];
      final dens = res['data']?['denominations'] ?? raw?['denominations'];
      setState(() {
        _business = raw is Map
            ? BusinessModel.fromJson(Map<String, dynamic>.from(raw))
            : null;
        _denoms = dens is List
            ? dens.map((e) => double.tryParse('$e') ?? 0).where((e) => e > 0).toList()
            : (_business?.denominations ?? []);
        if (_denoms.isNotEmpty) _selected = _denoms.first;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    }
  }

  Future<String?> _askPhone() async {
    final phoneCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pay'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: TZS ${_selected?.toStringAsFixed(0) ?? '0'}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            TextField(
          controller: phoneCtrl,
          keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Submit')),
        ],
      ),
    );
    if (ok != true) return null;
    final phone = phoneCtrl.text.trim();
    return phone.isEmpty ? null : phone;
  }

  Future<void> _buy() async {
    if (_selected == null) return;
    String? phone;
    if (_payment != 'wallet') {
      phone = await _askPhone();
      if (phone == null) return;
    }
    setState(() => _buying = true);
    try {
      final res = await _api.purchaseGiftCard(
        businessId: widget.businessId,
        amount: _selected!,
        paymentMethod: _payment,
        phone: phone,
      );
      if (!mounted) return;
      final payload = res['data'] is Map ? Map<String, dynamic>.from(res['data'] as Map) : res;
      if (payload['payment_required'] == true) {
        await Navigator.push(
          context,
          GiftCardPaymentScreen.route(
            paymentUrl: GiftCardPayment.fromApi(payload, amount: _selected),
            reference: payload['reference']?.toString(),
            amount: _selected,
            title: 'Pay for gift card',
          ),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gift card purchased')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _buying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F5),
      appBar: AppBar(
        title: Text(_business?.name ?? 'Brand'),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE54747), Color(0xFF8B1E3F)],
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  _business?.description ?? 'Choose an amount and send a gift instantly.',
                  style: TextStyle(color: Colors.grey[700], height: 1.4),
                ),
                const SizedBox(height: 20),
                const Text('Amount', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _denoms
                      .map(
                        (d) => ChoiceChip(
                          label: Text('TZS ${d.toStringAsFixed(0)}'),
                          selected: _selected == d,
                          selectedColor: AppColor.primaryColor,
                          labelStyle: TextStyle(
                            color: _selected == d ? Colors.white : Colors.black87,
                          ),
                          onSelected: (_) => setState(() => _selected = d),
                        ),
                      )
                      .toList(),
                ),
                if (_denoms.isEmpty)
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Custom amount (TZS)'),
                    onChanged: (v) =>
                        setState(() => _selected = double.tryParse(v)),
                  ),
                const SizedBox(height: 20),
                const Text('Pay with', style: TextStyle(fontWeight: FontWeight.w700)),
                RadioListTile<String>(
                  value: 'wallet',
                  groupValue: _payment,
                  title: const Text('Wallet'),
                  onChanged: (v) => setState(() => _payment = v!),
                ),
                RadioListTile<String>(
                  value: 'mobile_money',
                  groupValue: _payment,
                  title: const Text('Mobile money / card (Dodesoft)'),
                  onChanged: (v) => setState(() => _payment = v!),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _buying ? null : _buy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: _buying
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Buy gift card'),
                  ),
                ),
              ],
            ),
    );
  }
}
