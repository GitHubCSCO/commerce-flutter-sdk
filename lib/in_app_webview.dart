import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/in_app_browser/in_app_browser_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/in_app_browser/in_app_browser_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowserScreen extends StatelessWidget {
  final String url;

  const InAppBrowserScreen({
    super.key,
    required this.url,
  });

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

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
// Retrieve the token from the Cubit
            final cubit = context.read<InAppBrowserCubit>();
            final token = cubit.accessToken;

            if (token != null && token.isNotEmpty) {
              // Inject JavaScript to include the token in outgoing requests
              await _controller.runJavaScript(
                """
                (function() {
                  const token = "$token";

                  // Patch XMLHttpRequest to include Authorization header
                  const open = XMLHttpRequest.prototype.open;
                  XMLHttpRequest.prototype.open = function() {
                    open.apply(this, arguments);
                    this.setRequestHeader('Authorization', 'Bearer ' + token);
                  };

                  // Patch fetch to include Authorization header
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
           
            } else {
              print("No token available to inject.");
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
    final cubit = context.read<InAppBrowserCubit>();

    return BlocListener<InAppBrowserCubit, InAppBrowserState>(
      listener: (context, state) {
        if (state is InAppBrowserTokenUpdatedState) {
          _updateWebViewWithToken(state.token);
        } else if (state is InAppBrowserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('')),
        body: FutureBuilder<void>(
          future: _initializeWebView(cubit.accessToken),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return WebViewWidget(controller: _controller);
          },
        ),
      ),
    );
  }

  Future<void> _initializeWebView(String bearerToken) async {
    final uri = Uri.parse(widget.url);

    // Add headers
    final headers = {'Authorization': 'Bearer $bearerToken'};

    // Load the request
    try {
      await _controller.loadRequest(uri, headers: headers);
    } catch (error) {}
  }

  void _updateWebViewWithToken(String newToken) {
    try {
      _controller.runJavaScript(
        """
        (function() {
          const token = "$newToken";

          // Patch XMLHttpRequest to include the updated Authorization header
          const open = XMLHttpRequest.prototype.open;
          XMLHttpRequest.prototype.open = function() {
            open.apply(this, arguments);
            this.setRequestHeader('Authorization', 'Bearer ' + token);
          };

          // Patch fetch API to include the updated Authorization header
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
