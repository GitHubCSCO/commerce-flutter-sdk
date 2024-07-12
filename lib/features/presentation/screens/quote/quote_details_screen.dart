import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteDetailsScreen extends StatelessWidget {
  final QuoteDto? quoteDto;

  const QuoteDetailsScreen({super.key, this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuoteDetailsBloc>()..add(LoadQuoteDetailsEvent()),
      child: QuoteDetailsPage(quoteDto: quoteDto),
    );
  }
}

class QuoteDetailsPage extends StatelessWidget {
  final QuoteDto? quoteDto;

  const QuoteDetailsPage({super.key, this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QuoteInformationWidget(quoteDto: quoteDto),
          ],
        ),
      ),
    );
  }
}
