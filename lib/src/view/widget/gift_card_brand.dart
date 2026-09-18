import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/core/app_data.dart';

/// Shared GiftCard wordmark used on splash, login, and OTP screens.
class GiftCardBrand extends StatelessWidget {
  const GiftCardBrand({
    super.key,
    this.iconSize = 72,
    this.fontSize = 28,
    this.showSubtitle = false,
  });

  final double iconSize;
  final double fontSize;
  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.card_giftcard,
          size: iconSize,
          color: AppColor.primaryColor,
        ),
        const SizedBox(height: 12),
        Text(
          AppData.appName,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
            color: AppColor.primaryColor,
          ),
        ),
        if (showSubtitle) ...[
          const SizedBox(height: 4),
          Text(
            'Gift cards made simple',
            style: TextStyle(
              fontSize: fontSize * 0.4,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}
