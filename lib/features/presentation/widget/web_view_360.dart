import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView360Widget extends StatefulWidget {
  final String htmlString;

  const WebView360Widget({Key? key, required this.htmlString}) : super(key: key);

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
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');

            // Inject CSS to hide the scrollbar once the page is fully loaded
            try {
              await _webViewController.runJavaScript('''
                (function() {
                  var style = document.createElement("style");
                  // Note the careful use of escaping and newlines:
                  style.innerHTML = "::-webkit-scrollbar { display: none; }\\n"
                    + "html, body { scrollbar-width: none; -ms-overflow-style: none; margin: 0; padding: 0; }";
                  document.head.appendChild(style);
                })();
              ''');
            } catch (e) {
              debugPrint('JavaScript injection error: $e');
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error loading page: ${error.description}');
          },
        ),
      )
      ..loadRequest(
        Uri.dataFromString(
          '''
          <!DOCTYPE html>
          <html>
            <head>
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
            </head>
            <body style="margin:0;padding:0;">
              <!-- Insert your HTML or <img> tag here -->
              ${widget.htmlString}
            </body>
          </html>
          ''',
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