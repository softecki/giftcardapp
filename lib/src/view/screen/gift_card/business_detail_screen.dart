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
  final _phoneCtrl = TextEditingController();
  BusinessModel? _business;
  List<double> _denoms = [];
  double? _selected;
  bool _loading = true;
  bool _buying = false;
  final String _payment = 'mobile_money';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
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

  InputDecoration _field(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon == null ? null : Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.black.withOpacity(0.06)),
      ),
    );
  }

  Future<void> _buy() async {
    if (_selected == null) return;
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the phone number to pay with')),
      );
      return;
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
      backgroundColor: AppColor.cream,
      appBar: AppBar(
        title: Text(_business?.name ?? 'Brand'),
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE54747), Color(0xFF8B1E3F)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.28),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.card_giftcard, color: Colors.white, size: 36),
                      const SizedBox(height: 12),
                      Text(
                        _business?.name ?? 'Gift card',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _business?.description ??
                            'Choose an amount and pay with mobile money or card.',
                        style: TextStyle(color: Colors.white.withOpacity(0.9), height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Amount', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _denoms.map((d) {
                    final selected = _selected == d;
                    return ChoiceChip(
                      label: Text('TZS ${d.toStringAsFixed(0)}'),
                      selected: selected,
                      selectedColor: AppColor.primaryColor,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : AppColor.ink,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: selected
                              ? AppColor.primaryColor
                              : Colors.black.withOpacity(0.06),
                        ),
                      ),
                      onSelected: (_) => setState(() => _selected = d),
                    );
                  }).toList(),
                ),
                if (_denoms.isEmpty)
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: _field('Custom amount (TZS)', icon: Icons.payments_outlined),
                    onChanged: (v) => setState(() => _selected = double.tryParse(v)),
                  ),
                const SizedBox(height: 24),
                const Text('Pay with', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColor.primaryColor.withOpacity(0.35)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0x1AE54747),
                        child: Icon(Icons.phone_iphone, color: AppColor.primaryColor),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Money / Card',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Pay from your phone or card',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.check_circle, color: AppColor.primaryColor),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: _field('Phone number', icon: Icons.phone_outlined),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _buying ? null : _buy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _buying
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            'Buy gift card${_selected == null ? '' : ' · TZS ${_selected!.toStringAsFixed(0)}'}',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
