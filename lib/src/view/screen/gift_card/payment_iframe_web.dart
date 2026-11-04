import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/widgets.dart';

Widget buildPaymentIframe(String url) {
  final viewType = 'dodesoft-pay-${DateTime.now().microsecondsSinceEpoch}';
  ui_web.platformViewRegistry.registerViewFactory(viewType, (int id) {
    final iframe = html.IFrameElement()
      ..src = url
      ..allow = 'payment *'
      ..style.border = 'none'
      ..width = '100%'
      ..height = '100%';
    return iframe;
  });
  return HtmlElementView(viewType: viewType);
}
