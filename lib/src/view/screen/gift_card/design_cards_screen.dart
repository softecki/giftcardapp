import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/models/business_model.dart';
import 'package:malipo_agent/models/gift_card_model.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';

class DesignCardsScreen extends StatefulWidget {
  const DesignCardsScreen({super.key});

  @override
  State<DesignCardsScreen> createState() => _DesignCardsScreenState();
}

class _DesignCardsScreenState extends State<DesignCardsScreen> {
  final _api = GiftCardApiService();
  final _amount = TextEditingController();
  BusinessModel? _business;
  List<double> _denoms = [];
  List<GiftCardModel> _issued = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final mine = await _api.getMyBusiness();
      final raw = mine['data']?['business'];
      BusinessModel? biz;
      if (raw is Map) {
        biz = BusinessModel.fromJson(Map<String, dynamic>.from(raw));
      }
      List<GiftCardModel> issued = [];
      try {
        final cards = await _api.getIssuedCards();
        issued = ((cards['data']?['gift_cards'] as List?) ?? [])
            .whereType<Map>()
            .map((e) => GiftCardModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } catch (_) {}
      setState(() {
        _business = biz;
        _denoms = List<double>.from(biz?.denominations ?? []);
        _issued = issued;
        _loading = false;
      });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  Future<void> _addAmount() async {
    final value = double.tryParse(_amount.text.trim());
    if (value == null || value <= 0 || _business == null) return;
    final next = {..._denoms, value}.toList()..sort();
    await _api.updateBusiness(id: _business!.id, denominations: next);
    _amount.clear();
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_business == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Set up your shop first to design card amounts.'),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFE54747), Color(0xFF8B1E3F)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _business!.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _business!.description ?? 'Customers pick one of these amounts.',
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Card amounts (TZS)', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _denoms
                .map(
                  (d) => Chip(
                    label: Text(d.toStringAsFixed(0)),
                    backgroundColor: Colors.white,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'New amount'),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _addAmount, child: const Text('Add')),
            ],
          ),
          const SizedBox(height: 28),
          const Text('Cards sold', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          if (_issued.isEmpty)
            Text('No cards sold yet', style: TextStyle(color: Colors.grey[600]))
          else
            ..._issued.map(
              (c) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppColor.primaryColor,
                  child: Icon(Icons.card_giftcard, color: Colors.white),
                ),
                title: Text(c.cardCode),
                subtitle: Text('${c.status} · TZS ${c.currentBalance.toStringAsFixed(0)} left'),
              ),
            ),
        ],
      ),
    );
  }
}
