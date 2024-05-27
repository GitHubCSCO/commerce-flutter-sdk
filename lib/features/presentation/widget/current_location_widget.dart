import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/widget/current_location_widget_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationWidget extends StatelessWidget {
  final CurrentLocationWidgetEntity currentLocationWidgetEntity;

  const CurrentLocationWidget(
      {super.key, required this.currentLocationWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
        builder: (context, state) {
      if (state is CurrentLocationLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CurrentLocationLoadedState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                currentLocationWidgetEntity.title ?? "",
                style: OptiTextStyles.titleSmall,
              ),
            ),
            CurrentLocationWidgetItem(
                locationData: state.currentLocationDataEntity),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
