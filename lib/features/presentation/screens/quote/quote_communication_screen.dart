import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_state.dart';
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
      body: BlocConsumer<QuoteCommunicationBloc, QuoteCommunicationState>(
        listener: (context, state) {
          if (state is QuoteCommunicationFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is QuoteCommunicationLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuoteCommunicationLoadedState) {
            return _buildQuoteCommunicationWidget(context, state.quoteDto);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildQuoteCommunicationWidget(
      BuildContext context, QuoteDto quoteDto) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: quoteDto.messageCollection?.length,
        itemBuilder: (context, index) {
          return QuoteMessageItem(message: quoteDto.messageCollection?[index]);
        },
      ),
    );
  }
}

class QuoteMessageItem extends StatelessWidget {
  final QuoteMessage? message;

  QuoteMessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Text(
                  message?.displayName?[0] ?? "",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                message?.displayName ?? "",
                style: OptiTextStyles.subtitle,
              ),
            ],
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message?.body ?? "",
                        style: OptiTextStyles.body,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    message!.createdDate
                        .formatDate(format: CoreConstants.dateFormatFullString),
                    style: OptiTextStyles.bodyFade,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
