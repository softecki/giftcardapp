import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/models/gift_card_model.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';

class MyGiftCardsScreen extends StatefulWidget {
  const MyGiftCardsScreen({super.key});

  @override
  State<MyGiftCardsScreen> createState() => _MyGiftCardsScreenState();
}

class _MyGiftCardsScreenState extends State<MyGiftCardsScreen> {
  final _api = GiftCardApiService();
  List<GiftCardModel> _cards = [];
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
      final res = await _api.getMyGiftCards();
      final list = (res['data']?['gift_cards'] as List?) ?? [];
      setState(() {
        _cards = list
            .whereType<Map>()
            .map((e) => GiftCardModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }
    if (_cards.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.card_giftcard, size: 72, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                'Your cards will show here',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Buy a gift card from Shop, then copy the code or show it at the merchant.',
                style: TextStyle(color: Colors.grey[600], height: 1.4),
                textAlign: TextAlign.center,
              ),
              TextButton(onPressed: _load, child: const Text('Refresh')),
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _cards.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final c = _cards[i];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: c.isActive
                    ? [AppColor.primaryColor, const Color(0xFF8B1E3F)]
                    : [Colors.blueGrey, Colors.blueGrey.shade700],
              ),
            ),
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.business?.name ?? 'Gift card',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'TZS ${c.currentBalance.toStringAsFixed(0)} left',
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
                Text(
                  'of TZS ${c.originalAmount.toStringAsFixed(0)}  •  ${c.status}',
                  style: TextStyle(color: Colors.white.withOpacity(0.85)),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        c.cardCode,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.2,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: c.cardCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Code copied')),
                        );
                      },
                      icon: const Icon(Icons.copy, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
