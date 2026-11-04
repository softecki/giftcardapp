class GiftCardPayment {
  GiftCardPayment._();

  static const String checkoutUrl =
      'https://gate.dodesoft.com/p/121c47a3-4f60-4632-8c2a-a2b988d3f09a/details/';

  static String urlFor({double? amount, String? reference}) {
    final uri = Uri.parse(checkoutUrl);
    return uri.replace(
      queryParameters: {
        if (amount != null) 'amount': amount.toStringAsFixed(0),
        if (reference != null && reference.isNotEmpty) 'reference': reference,
      },
    ).toString();
  }

  static String fromApi(dynamic payload, {double? amount, String? reference}) {
    if (payload is Map) {
      final nested = payload['data'];
      final url = payload['checkout_url'] ??
          payload['checkoutUrl'] ??
          payload['payment_url'] ??
          (nested is Map
              ? (nested['checkout_url'] ??
                  nested['checkoutUrl'] ??
                  nested['payment_url'])
              : null);
      if (url != null && url.toString().trim().isNotEmpty) {
        return url.toString();
      }
    }
    return urlFor(amount: amount, reference: reference);
  }
}
