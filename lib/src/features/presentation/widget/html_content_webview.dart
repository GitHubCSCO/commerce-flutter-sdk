import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlContentWebView extends StatefulWidget {
  final String htmlContent;
  final TextStyle? textStyle;

  const HtmlContentWebView({
    super.key,
    required this.htmlContent,
    this.textStyle,
  });

  @override
  State<HtmlContentWebView> createState() => _HtmlContentWebViewState();
}

class _HtmlContentWebViewState extends State<HtmlContentWebView> {
  late WebViewController controller;
  double webViewHeight = 200; // Default height

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    unawaited(_initializeWebView());
  }

  Future<void> _initializeWebView() async {
    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (String url) {
          // Get the content height and update the WebView height
          unawaited(_updateWebViewHeight());
        },
      ),
    );
    await controller.loadHtmlString(_buildCompleteHtml());
  }

  String _buildCompleteHtml() {
    // Build a complete HTML document with proper styling
    final style = widget.textStyle;
    final fontSize = style?.fontSize ?? 14;
    final color = style?.color != null
        ? style!.color!
            .toARGB32()
            .toRadixString(16)
            .padLeft(8, '0')
            .substring(2)
        : '666666';
    final fontFamily =
        style?.fontFamily ?? '-apple-system, BlinkMacSystemFont, sans-serif';

    return '''
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <style>
        body {
            margin: 0;
            padding: 16px;
            font-family: $fontFamily;
            font-size: ${fontSize}px;
            color: #$color;
            line-height: 1.5;
        }
        ul, ol {
            margin: 0;
            padding-left: 20px;
        }
        li {
            margin-bottom: 8px;
        }
        p {
            margin: 0 0 16px 0;
        }
        * {
            max-width: 100%;
        }
    </style>
    <script>
        function getContentHeight() {
            return Math.max(
                document.body.scrollHeight,
                document.body.offsetHeight,
                document.documentElement.clientHeight,
                document.documentElement.scrollHeight,
                document.documentElement.offsetHeight
            );
        }
        
        window.addEventListener('load', function() {
            setTimeout(function() {
                const height = getContentHeight();
                if (window.flutter_inappwebview) {
                    window.flutter_inappwebview.callHandler('contentHeight', height);
                }
            }, 100);
        });
    </script>
</head>
<body>
    ${widget.htmlContent}
</body>
</html>
    ''';
  }

  Future<void> _updateWebViewHeight() async {
    try {
      // Get the content height from JavaScript
      final heightResult = await controller.runJavaScriptReturningResult(
        'getContentHeight();',
      );
      double? newHeight;
      if (heightResult is num) {
        newHeight = heightResult.toDouble();
      } else if (heightResult is String) {
        // Remove quotes if present and try to parse
        final parsed = double.tryParse(heightResult.replaceAll('"', ''));
        if (parsed != null) newHeight = parsed;
      }
      if (newHeight != null && (newHeight - webViewHeight).abs() > 1) {
        setState(() {
          webViewHeight = newHeight! + 20; // Add some padding
        });
      }
    } catch (e) {
      // If JavaScript fails, keep the default height
      debugPrint('Failed to get WebView content height: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: webViewHeight,
      child: WebViewWidget(controller: controller),
    );
  }
}
