import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';

Widget buildPaymentIframe(String url) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.payment, size: 48, color: AppColor.primaryColor),
          const SizedBox(height: 12),
          const Text(
            'Continue on the payment page to finish',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          SelectableText(url, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
