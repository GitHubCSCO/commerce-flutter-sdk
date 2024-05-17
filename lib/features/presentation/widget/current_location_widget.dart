import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_state.dart';
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
        return Container(
          child: Text(currentLocationWidgetEntity.title ?? ""),
        );
      } else if (state is CurrentLocationLoadedState) {
        return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.currentLocationDataEntity.locationName ?? "",
                      style: OptiTextStyles.subtitle),
                  Text(state.currentLocationDataEntity.firestLineValue ?? "",
                      style: OptiTextStyles.body),
                  Text(state.currentLocationDataEntity.secondLineValue ?? "",
                      style: OptiTextStyles.body),
                  Text(state.currentLocationDataEntity.thridLineValue ?? "",
                      style: OptiTextStyles.body),
                  const SizedBox(height: 16),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Text(
                            LocalizationConstants.call,
                            textAlign: TextAlign.center,
                            style: OptiTextStyles.link,
                          ),
                          onTap: () {
                            // _onHoursClick(context);
                          },
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          child: Text(
                            LocalizationConstants.directions,
                            textAlign: TextAlign.center,
                            style: OptiTextStyles.link,
                          ),
                          onTap: () {
                            // _onDirectionsClick();
                          },
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          child: Text(
                            LocalizationConstants.changeLocation,
                            textAlign: TextAlign.center,
                            style: OptiTextStyles.link,
                          ),
                          onTap: () {
                            // _onDirectionsClick();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      } else {
        return Container();
      }
    });
  }
}
