import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/in_app_browser/in_app_browser_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/in_app_browser/in_app_browser_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowserScreen extends StatelessWidget {
  final String url;

  const InAppBrowserScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InAppBrowserCubit>()..initializeTokens(),
      child: InAppBrowser(url: url),
    );
  }
}

class InAppBrowser extends StatefulWidget {
  final String url;

  const InAppBrowser({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<InAppBrowser> createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser> {
  late WebViewController _controller;
  int _tokenInjectionCount = 0;
  String? _token;
  bool _webViewInitialized = false;
  bool _isLoading = false; // For tracking the loading state of the WebView

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            // Hide the loading indicator
            setState(() {
              _isLoading = false;
            });

            // If token is available, try injecting it again if not already done
            if (_token != null &&
                _token!.isNotEmpty &&
                _tokenInjectionCount < 2) {
              try {
                await _injectToken(_token!);
                _tokenInjectionCount++;
              } catch (e) {
                print("Error injecting token: $e");
              }
            } else {
              print("No token available or injection limit reached.");
            }
          },
          onHttpError: (HttpResponseError error) {
            if (error.response?.statusCode == 401) {
              // Token expired, refresh token
              context.read<InAppBrowserCubit>().refreshToken();
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://restricted.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InAppBrowserCubit, InAppBrowserState>(
      listener: (context, state) async {
        if (state is InAppBrowserTokenUpdatedState) {
          // We got a token, initialize the webview now
          _token = state.token;
          if (!_webViewInitialized) {
            await _initializeWebView(_token!);
            setState(() {
              _webViewInitialized = true;
            });
          } else {
            // Token updated after initial load, re-inject token
            await _injectToken(_token!);
          }
        } else if (state is InAppBrowserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
      },
      builder: (context, state) {
        // If we haven't initialized the webview yet (e.g., token not loaded),
        // show a loading indicator
        if (!_webViewInitialized) {
          return Scaffold(
            appBar: AppBar(title: Text('')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // Once initialized, show the WebView with a Stack to overlay the loader
        return Scaffold(
          appBar: AppBar(title: Text('')),
          body: Stack(
            children: [
              // The WebView itself
              WebViewWidget(controller: _controller),
              // A centered CircularProgressIndicator when page is loading
              if (_isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }

  Future<void> _initializeWebView(String bearerToken) async {
    final uri = Uri.parse(widget.url);
    final headers = {'Authorization': 'Bearer $bearerToken'};

    try {
      await _controller.loadRequest(uri, headers: headers);
    } catch (error) {
      print("Error loading initial request: $error");
    }
  }

  Future<void> _injectToken(String newToken) async {
    try {
      await _controller.runJavaScript(
        """
        (function() {
          const token = "$newToken";

          // Patch XMLHttpRequest to include Authorization header
          const open = XMLHttpRequest.prototype.open;
          XMLHttpRequest.prototype.open = function() {
            open.apply(this, arguments);
            this.setRequestHeader('Authorization', 'Bearer ' + token);
          };

          // Patch fetch API to include Authorization header
          const originalFetch = window.fetch;
          window.fetch = function(input, init = {}) {
            if (!init.headers) {
              init.headers = {};
            }
            init.headers['Authorization'] = 'Bearer ' + token;
            return originalFetch(input, init);
          };
        })();
        """,
      );
    } catch (error) {
      print("Error updating WebView with new token: $error");
    }
  }
}
