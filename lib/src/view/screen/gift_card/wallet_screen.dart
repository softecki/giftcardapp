import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/core/gift_card_payment.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';
import 'payment_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _api = GiftCardApiService();
  double _balance = 0;
  List<dynamic> _tx = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final bal = await _api.getWalletBalance();
      final txs = await _api.getWalletTransactions();
      setState(() {
        _balance = double.tryParse('${bal['data']?['balance'] ?? 0}') ?? 0;
        _tx = (txs['data']?['transactions'] as List?) ?? [];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _loading = false;
      });
    }
  }

  Future<void> _deposit() async {
    final amountCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add money'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mobile Money / Card',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount (TZS)'),
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
    if (submitted != true) return;
    final amount = double.tryParse(amountCtrl.text.trim());
    final phone = phoneCtrl.text.trim();
    if (amount == null || amount <= 0 || phone.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter amount and phone number')),
      );
      return;
    }
    try {
      final res = await _api.depositWallet(
        amount: amount,
        phone: phone,
        paymentMethod: 'mobile_money',
      );
      if (!mounted) return;
      final payload = res['data'] is Map ? res['data'] as Map : res;
      final url = GiftCardPayment.fromApi(payload, amount: amount);
      await Navigator.push(
        context,
        GiftCardPaymentScreen.route(
          paymentUrl: url,
          reference: payload['reference']?.toString(),
          amount: amount,
          title: 'Complete payment',
        ),
      );
      await _load();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, textAlign: TextAlign.center),
            TextButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    return RefreshIndicator(
      color: AppColor.primaryColor,
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
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
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Wallet balance', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Text(
                  'TZS ${_balance.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _deposit,
                  icon: const Icon(Icons.add),
                  label: const Text('Top up'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Recent activity', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          if (_tx.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Icon(Icons.receipt_long_outlined, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  Text(
                    'No wallet activity yet',
                    style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Top up to buy gift cards from the shop tab.',
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ..._tx.map((raw) {
              final m = raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColor.primaryColor.withOpacity(0.12),
                  child: const Icon(Icons.swap_vert, color: AppColor.primaryColor),
                ),
                title: Text('${m['type'] ?? 'Transaction'}'),
                subtitle: Text('${m['created_at'] ?? ''}'),
                trailing: Text('${m['amount'] ?? ''}'),
              );
            }),
        ],
      ),
    );
  }
}
