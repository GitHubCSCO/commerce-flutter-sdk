import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/currency_bloc/currency_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/currency_bloc/currency_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/currency_bloc/currency_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/currency/currency_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class CurrencyScreen extends BaseStatelessWidget {
  const CurrencyScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider<CurrencyBloc>(
      create: (context) => sl<CurrencyBloc>()..add(CurrencyListLoadEvent()),
      child: const CurrencyPage(),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameCurrencies,
      );

  @override
  TelemetryEvent getTelemetryScreenEvent() => TelemetryEvent(
        screenName: AnalyticsConstants.screenNameCurrencies,
      );
}

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.currencies.localized(),
            style: context.text.titleLarge),
      ),
      body: BlocListener<CurrencyBloc, CurrencyState>(
        listenWhen: (previous, current) => current is CurrencyChanged,
        listener: (context, state) {
          if (state is CurrencyChanged) {
            context.read<RootBloc>().add(RootConfigChangeEvent());
          }
        },
        child: BlocBuilder<CurrencyBloc, CurrencyState>(
          buildWhen: (previous, current) =>
              current is CurrencyInitial ||
              current is CurrencyLoading ||
              current is CurrencyListLoaded ||
              current is CurrencyFailedToLoad,
          builder: (context, state) {
            switch (state) {
              case CurrencyInitial():
              case CurrencyLoading():
                return const Center(child: CircularProgressIndicator());
              case CurrencyListLoaded():
                final currencies = state.currencies;
                final selectedCurrency = state.selectedCurrency;
                return Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.separated(
                    itemCount: currencies?.length ?? 0,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Divider(
                      height: 0,
                      thickness: 0.3,
                    ),
                    itemBuilder: (context, index) {
                      final currency = currencies![index];
                      final isSelected = selectedCurrency != null &&
                          selectedCurrency.id != null &&
                          currency.id != null &&
                          selectedCurrency.id == currency.id;
                      return CurrencyItem(
                        currency: currency,
                        isSelected: isSelected,
                        onCallBack: (context, currency) {
                          context
                              .read<CurrencyBloc>()
                              .add(CurrencyChangeEvent(currency: currency));
                        },
                      );
                    },
                  ),
                );
              case CurrencyFailedToLoad():
              default:
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(
                      child: Center(
                        child: Text(LocalizationConstants.error.localized()),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
