import 'dart:async';
import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';
import 'checkout_open_stub.dart'
    if (dart.library.html) 'checkout_open_web.dart';

class GiftCardPaymentScreen extends StatefulWidget {
  const GiftCardPaymentScreen({
    super.key,
    required this.paymentUrl,
    this.reference,
    this.title = 'Pay',
  });

  final String paymentUrl;
  final String? reference;
  final String title;

  static Route<bool> route({
    String? paymentUrl,
    String? reference,
    double? amount,
    String title = 'Pay',
  }) {
    return MaterialPageRoute(
      builder: (_) => GiftCardPaymentScreen(
        paymentUrl: paymentUrl ?? '',
        reference: reference,
        title: title,
      ),
    );
  }

  @override
  State<GiftCardPaymentScreen> createState() => _GiftCardPaymentScreenState();
}

class _GiftCardPaymentScreenState extends State<GiftCardPaymentScreen>
    with WidgetsBindingObserver {
  final _api = GiftCardApiService();
  Timer? _timer;
  bool _checking = false;
  String _message = 'Complete payment in the new tab.';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _openCheckout());
    _timer = Timer.periodic(const Duration(seconds: 8), (_) => _checkStatus());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkStatus();
    }
  }

  void _openCheckout() {
    if (widget.paymentUrl.isEmpty) return;
    openCheckoutUrl(widget.paymentUrl);
  }

  Future<void> _checkStatus() async {
    final ref = widget.reference;
    if (ref == null || ref.isEmpty || _checking) return;
    setState(() => _checking = true);
    try {
      final res = await _api.paymentStatus(reference: ref);
      final data = res['data'] is Map ? Map<String, dynamic>.from(res['data'] as Map) : res;
      final settled = data['settled'] == true;
      if (!mounted) return;
      setState(() {
        _message = '${data['message'] ?? 'Waiting for payment'}';
        _checking = false;
      });
      if (settled) {
        _timer?.cancel();
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _checking = false;
        _message = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.open_in_new, size: 48, color: AppColor.primaryColor),
            const SizedBox(height: 16),
            const Text(
              'Finish payment on the SoftePay page',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(_message, textAlign: TextAlign.center),
            if (widget.reference != null) ...[
              const SizedBox(height: 12),
              Text(
                'Reference: ${widget.reference}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _openCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Open payment page'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _checking ? null : _checkStatus,
              child: _checking
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Check status'),
            ),
          ],
        ),
      ),
    );
  }
}
