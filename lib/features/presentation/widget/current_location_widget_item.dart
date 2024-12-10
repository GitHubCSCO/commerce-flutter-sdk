import 'dart:async';

import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/location_search_type.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/location_search_handler/location_search_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/vmi_location_select_callback_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentLocationWidgetItem extends StatelessWidget with MapDirection {
  final CurrentLocationDataEntity locationData;
  final bool isVMILocationfinder;

  CurrentLocationWidgetItem(
      {super.key,
      required this.locationData,
      required this.isVMILocationfinder});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locationData.locationName ?? "",
              style: OptiTextStyles.subtitle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              locationData.firestLineValue ?? "",
              style: OptiTextStyles.body,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              locationData.secondLineValue ?? "",
              style: OptiTextStyles.body,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              locationData.thridLineValue ?? "",
              style: OptiTextStyles.body,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      LocalizationConstants.call.localized(),
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    onTap: () {
                      _onmakeCall(locationData.thridLineValue ?? "");
                    },
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: Text(
                      LocalizationConstants.directions.localized(),
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    onTap: () {
                      _onDirectionsClick(locationData.latLong?.latitude ?? 0.0,
                          locationData.latLong?.longitude ?? 0.0);
                    },
                  ),
                  const SizedBox(width: 16),
                  BlocListener<LocationSearchHandlerCubit,
                      LocationSearchHandlerState>(
                    listener: (context, state) {
                      if (state.locationData != null) {
                        unawaited(context
                            .read<CurrentLocationCubit>()
                            .onLocationSelectEvent(state.locationData!));

                        unawaited(context
                            .read<CurrentLocationCubit>()
                            .onLoadLocationData());

                        context
                            .read<LocationSearchHandlerCubit>()
                            .clearLocationData();
                      }
                    },
                    child: Visibility(
                        visible: isVMILocationfinder,
                        child: InkWell(
                          child: Text(
                            LocalizationConstants.changeLocation.localized(),
                            textAlign: TextAlign.center,
                            style: OptiTextStyles.link,
                          ),
                          onTap: () {
                            _onChangeLocationClick(context);
                          },
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onmakeCall(String phoneNumber) async {
    final Uri call = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(call)) {
      await launchUrl(call);
    }
  }

  Future<void> _onDirectionsClick(double longitude, double latitude) async {
    await launchMap(latitude, longitude);
  }

  Future<void> _onChangeLocationClick(BuildContext context) async {
    AppRoute.locationSearch.navigateBackStack(context,
        extra: const VMILocationSelectCallbackHelper(
            locationSearchType: LocationSearchType.vmi));
  }
}
