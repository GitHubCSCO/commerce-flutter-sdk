import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/expansion_panel/expansion_panel_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpansionPanelCubit>(
      create: (context) => sl<ExpansionPanelCubit>(),
      child: CheckoutPage(),
    );
  }

}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalizationConstants.checkout),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocalizationConstants.cancel,
              style: OptiTextStyles.subtitleLink,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SizedBox(
          height: 50,
          child: PrimaryButton(
            onPressed: () {
              context.read<ExpansionPanelCubit>().onContinueClick();
            },
            text: LocalizationConstants.continueText,
          ),
        ),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSummary(),
            BlocBuilder<ExpansionPanelCubit, ExpansionPanelState>(
              builder: (context, state) {
                List<Item>? list;
                switch (state) {
                  case ExpansionPanelChangeState():
                    list = state.list;
                }

                return ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    context.read<ExpansionPanelCubit>().onPanelExpansionChange(
                        index);
                  },
                  children: [
                    ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Billing & Shipping'),
                          );
                        },
                        body: ListTile(
                          title: Text('Item 1 child'),
                          subtitle: Text('Details goes here'),
                        ),
                        isExpanded: list?[0].isExpanded ?? true,
                        canTapOnHeader: true
                    ),
                    ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Payment Details'),
                          );
                        },
                        body: ListTile(
                          title: Text('Item 2 child'),
                          subtitle: Text('Details goes here'),
                        ),
                        isExpanded: list?[1].isExpanded ?? false,
                        canTapOnHeader: true
                    ),
                    ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Review Order'),
                          );
                        },
                        body: ListTile(
                          title: Text('Item 3 child'),
                          subtitle: Text('Details goes here'),
                        ),
                        isExpanded: list?[2].isExpanded ?? false,
                        canTapOnHeader: true
                    ),
                  ],
                );
              },
            )
          ]
      ),
    );
  }

  Widget _buildSummary() {
    List<Widget> list = [];
    list.add(_buildRow('Promo', '-\$20', OptiTextStyles.bodyFade)!);
    list.add(_buildRow('Subtotal', '-\$283.50', OptiTextStyles.subtitle)!);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: list
      ),
    );
  }

  Widget? _buildRow(String title, String body, TextStyle textStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Text(
            body,
            textAlign: TextAlign.center,
            style: textStyle,
          )
        ],
      );
    }
  }

}