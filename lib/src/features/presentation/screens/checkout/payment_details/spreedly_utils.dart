import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpreedlyUtils {
  static Future<String?> getBrowserInfo(BuildContext context) async {
    final completer = Completer<String?>();

    // Create a hidden WebView
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Flutter',
        onMessageReceived: (message) {
          completer.complete(message.message);
        },
      );

    final htmlContent =
        await rootBundle.loadString('assets/form/browser_info_form.html');
    final uri = Uri.dataFromString(htmlContent,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
    await controller.loadRequest(uri);

    // Create an offscreen WebView widget
    final webView = Opacity(
      opacity: 0.0,
      child: SizedBox(
        height: 1,
        width: 1,
        child: WebViewWidget(controller: controller),
      ),
    );

    // Add WebView temporarily to widget tree
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(builder: (context) => webView);
    overlay.insert(entry);

    // Wait for browser info
    final result = await completer.future;

    // Remove WebView
    entry.remove();

    return result;
  }

  Future<void> _loadLocalHtml() async {}
}
