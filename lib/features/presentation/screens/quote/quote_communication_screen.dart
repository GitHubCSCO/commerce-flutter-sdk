import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteCommunicationScreen extends StatelessWidget {
  final QuoteDto quoteDto;
  const QuoteCommunicationScreen({super.key, required this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuoteCommunicationBloc>()
        ..add((LoadQuoteQummunicationMessagesEvent(quoteDto))),
      child: QuoteCommunicationPage(),
    );
  }
}

class QuoteCommunicationPage extends StatelessWidget {
  const QuoteCommunicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Text("Quote Communication Page"),
    );
  }
}
