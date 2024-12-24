import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView360Widget extends StatefulWidget {
  final String htmlString;
  const WebView360Widget({super.key, required this.htmlString});

  @override
  State<WebView360Widget> createState() => _WebView360WidgetState();
}

class _WebView360WidgetState extends State<WebView360Widget> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    // 1. Create the controller
    _webViewController = WebViewController()
      // 2. Set JavaScript (if needed)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // 3. Optionally set navigation delegates
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Loading 360 HTML: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error: $error');
          },
        ),
      )
      // 4. Load the HTML as a data URI
      ..loadRequest(
        Uri.dataFromString(
          widget.htmlString,
          mimeType: 'text/html',
          encoding: utf8,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Now pass the controller to a WebViewWidget
    return WebViewWidget(controller: _webViewController);
  }
}
