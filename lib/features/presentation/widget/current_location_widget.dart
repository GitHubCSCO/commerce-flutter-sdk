import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationWidget extends StatelessWidget with MapDirection {
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
            Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.currentLocationDataEntity.locationName ?? "",
                          style: OptiTextStyles.subtitle),
                      Text(
                          state.currentLocationDataEntity.firestLineValue ?? "",
                          style: OptiTextStyles.body),
                      Text(
                          state.currentLocationDataEntity.secondLineValue ?? "",
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
                                _onDirectionsClick(
                                    state.currentLocationDataEntity.latLong
                                            ?.latitude ??
                                        0.0,
                                    state.currentLocationDataEntity.latLong
                                            ?.longitude ??
                                        0.0);
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
                )),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Future<void> _onDirectionsClick(double longitude, double latitude) async {
    await launchMap(latitude, longitude);
  }
}
