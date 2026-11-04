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
  String _message = 'Finish paying with mobile money or card in the new tab.';

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
      backgroundColor: AppColor.cream,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0x1AE54747),
                    child: Icon(Icons.open_in_new, color: AppColor.primaryColor, size: 28),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Complete payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], height: 1.4),
                  ),
                  if (widget.reference != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.cream,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Reference: ${widget.reference}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _openCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Open payment page', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: _checking ? null : _checkStatus,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColor.primaryColor,
                  side: const BorderSide(color: AppColor.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _checking
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Check status', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
