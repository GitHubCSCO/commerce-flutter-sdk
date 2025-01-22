import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

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

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) => debugPrint('Loading 360 HTML: $url'),
          onPageFinished: (String url) => debugPrint('Finished loading: $url'),
          onWebResourceError: (WebResourceError error) =>
              debugPrint('Error: $error'),
        ),
      )
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
    return WebViewWidget(
      controller: _webViewController,
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
    );
  }
}
