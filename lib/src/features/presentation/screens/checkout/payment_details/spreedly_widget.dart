import 'dart:convert';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:webview_flutter/webview_flutter.dart';

class SpreedlyField {
  String fullName;
  String month;
  String year;

  SpreedlyField(this.fullName, this.month, this.year);
}

typedef HandleSpreedlyFinishedData = void Function(
    String cardNumber, String cardType, String cardIdentifier);

class SpreedlyWidget extends StatefulWidget {
  final String environmentKey;
  final HandleSpreedlyFinishedData handleSpreedlyFinishedData;
  final ValueNotifier<SpreedlyField?> spreedlyFieldUpdateNotifier;
  final ValueNotifier<bool>? unfocusWebViewNotifier;

  const SpreedlyWidget(
      {Key? key,
      required this.environmentKey,
      required this.handleSpreedlyFinishedData,
      required this.spreedlyFieldUpdateNotifier,
      this.unfocusWebViewNotifier})
      : super(key: key);

  @override
  State<SpreedlyWidget> createState() => _SpreedlyWidgetState();
}

class _SpreedlyWidgetState extends State<SpreedlyWidget> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    widget.spreedlyFieldUpdateNotifier
        .addListener(_onSpreedlyFieldUpdateNotifierChanged);
    widget.unfocusWebViewNotifier?.addListener(_unfocusWebView);
    // Initialize the WebView controller
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJSMessage(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            final envKey = widget.environmentKey;
            await _webViewController.runJavaScript('setEnvKey("$envKey");');
          },
        ),
      );

    // Load the local HTML asset
    _loadLocalHtml();
  }

  @override
  void dispose() {
    widget.spreedlyFieldUpdateNotifier
        .removeListener(_onSpreedlyFieldUpdateNotifierChanged);
    widget.unfocusWebViewNotifier?.removeListener(_unfocusWebView);
    super.dispose();
  }

  void _onSpreedlyFieldUpdateNotifierChanged() {
    var spreedlyField = widget.spreedlyFieldUpdateNotifier.value;
    if (spreedlyField != null) {
      var fullName = spreedlyField.fullName;
      var month = spreedlyField.month;
      var year = spreedlyField.year;

      _submitPaymentForm(fullName, month, year);
    }
  }

  void _unfocusWebView() {
    if (widget.unfocusWebViewNotifier?.value ?? false) {
      widget.unfocusWebViewNotifier?.value = false;
      _webViewController.runJavaScript('document.activeElement.blur();');
    }
  }

  Future<void> _loadLocalHtml() async {
    final htmlContent =
        await rootBundle.loadString(AssetConstants.speedredPaymentForm);
    final uri = Uri.dataFromString(htmlContent,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
    await _webViewController.loadRequest(uri);
  }

  void _submitPaymentForm(String fullName, String month, String year) async {
    if (fullName.isEmpty || month.isEmpty || year.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final jsCode = '''
      Spreedly.tokenizeCreditCard({
        full_name: "$fullName",
        month: "$month",
        year: "$year"
      });
    ''';

    await _webViewController.runJavaScript(jsCode);
  }

  void _handleJSMessage(String message) {
    final decoded = jsonDecode(message) as Map<String, dynamic>;
    final event = decoded['event'];
    final data = decoded['data'];

    switch (event) {
      case 'errors':
        debugPrint("Spreedly errors: $data");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $data')),
        );
        break;

      case 'paymentMethod':
        final token = data['token'];
        final paymentMethod = data['paymentMethod'];
        final String cardNumber = paymentMethod['number'];
        final String cardType = paymentMethod['card_type'];
        final String cardIdentifier = token;

        widget.handleSpreedlyFinishedData(cardNumber, cardType, cardIdentifier);
        debugPrint("Token received: $token");
        break;

      default:
        debugPrint("Unknown event: $event");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: WebViewWidget(controller: _webViewController),
    );
  }
}
