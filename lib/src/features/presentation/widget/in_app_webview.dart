import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/in_app_browser/in_app_browser_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/in_app_browser/in_app_browser_state.dart';

class InAppBrowserScreen extends StatelessWidget {
  final String url;

  const InAppBrowserScreen({Key? key, required this.url}) : super(key: key);

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

  const InAppBrowser({Key? key, required this.url}) : super(key: key);

  @override
  State<InAppBrowser> createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser> {
  late WebViewController _controller;
  int _tokenInjectionCount = 0;
  String? _token;
  bool _webViewInitialized = false;
  bool _isLoading = false;

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
            setState(() {
              _isLoading = false;
            });
            if (_token != null &&
                _token!.isNotEmpty &&
                _tokenInjectionCount < 2) {
              try {
                await _injectToken(_token!);
                _tokenInjectionCount++;
              } catch (e) {
                print("Error injecting token: $e");
              }
            }
          },
          onHttpError: (HttpResponseError error) {
            if (error.response?.statusCode == 401) {
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
          _token = state.token;
          if (!_webViewInitialized) {
            await _initializeWebView(_token!);
            setState(() {
              _webViewInitialized = true;
            });
          } else {
            if (_token != null && _token!.isNotEmpty) {
              try {
                await _injectToken(_token!);
              } catch (e) {
                print("Error injecting token: $e");
              }
            }
          }
        } else if (state is InAppBrowserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
      },
      builder: (context, state) {
        if (!_webViewInitialized) {
          return Scaffold(
            appBar: AppBar(title: Text('Browser')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Browser'),
            actions: [
              if (!_isLoading)
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _controller.reload();
                  },
                ),
            ],
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
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
          const open = XMLHttpRequest.prototype.open;
          XMLHttpRequest.prototype.open = function() {
            open.apply(this, arguments);
            this.setRequestHeader('Authorization', 'Bearer ' + token);
          };
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
