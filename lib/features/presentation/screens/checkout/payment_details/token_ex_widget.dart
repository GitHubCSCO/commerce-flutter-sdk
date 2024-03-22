import 'dart:convert';
import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef handleWebViewRequestFromTokenEX = void Function(String urlString);
typedef handleTokenExFinishedData = void Function(
    String cardNumber, String cardType, String securityCode);

class TokenExWebView extends StatelessWidget {
  final TokenExEntity tokenExEntity;
  final WebViewController _webViewController = WebViewController();
  final Function handleWebViewRequestFromTokenEX;
  final Function handleTokenExFinishedData;
  TokenExWebView(
      {super.key,
      required this.tokenExEntity,
      required this.handleWebViewRequestFromTokenEX,
      required this.handleTokenExFinishedData});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TokenExBloc, TokenExState>(
      listener: (context, state) {
        if (state is TokenExEncodeState) {
          String tokenExGetTokenScript =
              TokenExScripts.getTokenExGetTokenScript();
          _webViewController.runJavaScript(tokenExGetTokenScript);
        } else if (state is TokenExValidateState) {
          String tokenExValidateScript =
              TokenExScripts.getTokenExValidateScript();
          _webViewController.runJavaScript(tokenExValidateScript);
        } else if (state is TokenExEncodingFinishedState) {
          handleTokenExFinishedData(
              state.cardNumber, state.cardType, state.securityCode);
        }
      },
      child: WebViewWidget(
        controller: _webViewController
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                // DidFinishNavigation

                final isTokenExConfigurationSet =
                    context.read<TokenExBloc>().isTokenExConfigurationSet;

                if (!isTokenExConfigurationSet) {
                  String tokenExSetGetawayJSAction =
                      TokenExScripts.getTokenExSetupScript(
                    json.encode(tokenExEntity.tokenExConfiguration),
                    json.encode(tokenExEntity.tokenexStyle),
                    2,
                    json.encode(tokenExEntity.cardType!),
                  );
                  _webViewController.runJavaScript(tokenExSetGetawayJSAction);
                  // Create viewport meta tag script
                  final metaScript = StringBuffer();
                  metaScript
                      .writeln("var meta = document.createElement('meta');");
                  metaScript.writeln("meta.setAttribute('name', 'viewport');");
                  metaScript.writeln(
                      "meta.setAttribute('content', 'width=device-width, initial-scale=1, maximum-scale=1');");
                  metaScript.writeln(
                      "document.getElementsByTagName('head')[0].appendChild(meta);");

                  _webViewController.runJavaScript(metaScript.toString());
                }
              },
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                handleWebViewRequestFromTokenEX(request.url);
                if (request.url.endsWith('loaded')) {
                  // Handle loaded event
                  context.read<TokenExBloc>().add(
                      TokenExCongigurationSetEvent(isConfigurationSet: true));
                  handleLoaded();
                  return NavigationDecision.prevent;
                } else if (request.url.endsWith('error')) {
                  // Handle error event
                  handleLoadFailed();
                  return NavigationDecision.prevent;
                }

                final isTokenExConfigurationSet =
                    context.read<TokenExBloc>().isTokenExConfigurationSet;

                if (!isTokenExConfigurationSet) {
                  return NavigationDecision.navigate;
                } else {
                  return NavigationDecision.prevent;
                }
              },
            ),
          )
          ..loadRequest(Uri.parse(tokenExEntity.tokenExUrl!)),
      ),
    );
  }

  void handleLoaded() {
    // Handle loaded event
    // Notify parent or perform any necessary action
  }

  void handleLoadFailed() {
    // Handle load failed event
    // Notify parent or perform any necessary action
  }
}

class TokenExScripts {
  static String getTokenExSetupScript(
      String configuration, String style, int mode, String cardType) {
    return 'tokenExMobile.setUpTokenExGateway($configuration, $style, $mode, $cardType);';
  }

  static String getTokenExGetTokenScript() {
    return 'tokenExMobile.getToken();';
  }

  static String getTokenExValidateScript() {
    return 'tokenExMobile.validate();';
  }
}
