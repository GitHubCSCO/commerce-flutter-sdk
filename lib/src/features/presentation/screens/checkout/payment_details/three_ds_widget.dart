import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class Spreedly3DSWebView extends StatefulWidget {
  final String environmentKey;
  final String transactionToken;
  final Function(bool success) onAuthenticationComplete;

  const Spreedly3DSWebView({
    super.key,
    required this.environmentKey,
    required this.transactionToken,
    required this.onAuthenticationComplete,
  });

  @override
  State<Spreedly3DSWebView> createState() => _Spreedly3DSWebViewState();
}

class _Spreedly3DSWebViewState extends State<Spreedly3DSWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Flutter3DS', onMessageReceived: _handleJsMessage)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            final envKey = widget.environmentKey;
            final token = widget.transactionToken;
            await _controller.runJavaScript('setKeys("$envKey", "$token");');
          },
        ),
      );
    // Load the local HTML asset
    _loadLocalHtml();
  }

  void _handleJsMessage(JavaScriptMessage message) {
    final data = jsonDecode(message.message);
    if (data['type'] == '3dsStatus') {
      switch (data['action']) {
        case 'succeeded':
          widget.onAuthenticationComplete(true);
        case 'error':
        case 'finalization-timeout':
          widget.onAuthenticationComplete(false);
      }
    }
  }

  Future<void> _loadLocalHtml() async {
    final htmlContent =
        await rootBundle.loadString('assets/form/three_ds_form.html');
    final uri = Uri.dataFromString(htmlContent,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
    await _controller.loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Secure'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: WebViewWidget(controller: _controller)),
    );
  }
}
