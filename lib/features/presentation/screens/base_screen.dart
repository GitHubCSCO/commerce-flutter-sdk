import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});
  AnalyticsEvent getAnalyticsEvent();

  @override
  Widget build(BuildContext context) {
    context.read<RootBloc>().add(
          RootAnalyticsEvent(getAnalyticsEvent()),
        );
    // Let derived classes handle their own widget tree as usual
    return buildContent(context);
  }

  // Derived classes will override this method to build their widget tree
  Widget buildContent(BuildContext context);
}
