import 'dart:html' as html;

void openCheckoutUrl(String url) {
  html.window.open(url, '_blank', 'noopener,noreferrer');
}
