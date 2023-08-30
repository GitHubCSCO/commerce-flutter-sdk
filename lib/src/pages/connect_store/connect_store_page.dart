import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectStorePage extends ConsumerStatefulWidget {
  const ConnectStorePage({super.key});

  @override
  ConnectStorePageState createState() => ConnectStorePageState();
}

class ConnectStorePageState extends ConsumerState<ConnectStorePage> {
  final _urlFieldController = TextEditingController();
  final _urlFieldFocusNode = FocusNode();

  bool _isButtonEnabled = false;
  bool _isStorefrontLoading = false;

  @override
  void initState() {
    super.initState();
    _urlFieldController.addListener(_onTextNotEmpty);
  }

  void _onTextNotEmpty() {
    setState(() {
      _isButtonEnabled = _urlFieldController.text.isNotEmpty;
    });
  }

  void _onSubmitUrl() {
    _urlFieldFocusNode.unfocus();
    setState(() {
      _isStorefrontLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      final String url = 'https://${_urlFieldController.text}';
      ref.read(localStorageInterfaceProvider).save('hostUrl', url);

      ClientConfig.hostUrl = url;
      setState(() {
        _isStorefrontLoading = false;
        context.go('/storefront');
      });
    });
  }

  @override
  void dispose() {
    _urlFieldController.removeListener(_onTextNotEmpty);
    _urlFieldController.dispose();
    _urlFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/optimizely-logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                width: 350,
                height: 250,
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect Store',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 28,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          focusNode: _urlFieldFocusNode,
                          controller: _urlFieldController,
                          decoration: const InputDecoration(
                            alignLabelWithHint: false,
                            labelText: 'Enter Store URL',
                            hintText: 'Example store.optimizely.com',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (value) {
                            _onSubmitUrl();
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _isButtonEnabled ? _onSubmitUrl : null,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              child: const Text('Continue'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (_isStorefrontLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
