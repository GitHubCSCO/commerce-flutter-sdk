import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DealerLocationWidgetItem extends StatelessWidget with MapDirection {
  final Dealer dealerData;

  DealerLocationWidgetItem({
    required this.dealerData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dealerData.name ?? "",
                style: OptiTextStyles.subtitle,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                dealerData.address1 ?? "",
                style: OptiTextStyles.body,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                dealerData.address2 ?? "",
                style: OptiTextStyles.body,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                dealerData.phone ?? "",
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
                        LocalizationConstants.call,
                        textAlign: TextAlign.center,
                        style: OptiTextStyles.link,
                      ),
                      onTap: () {
                        // _onmakeCall(locationData.thridLineValue ?? "");
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
                        // _onDirectionsClick(
                        //     locationData.latLong?.latitude ?? 0.0,
                        //     locationData.latLong?.longitude ?? 0.0);
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
                        _onChangeLocationClick(context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onmakeCall(String phoneNumber) async {
    // final Uri call = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    // if (await canLaunchUrl(call)) {
    //   await launchUrl(call);
    // }
  }

  Future<void> _onDirectionsClick(double longitude, double latitude) async {
    await launchMap(latitude, longitude);
  }

  Future<void> _onChangeLocationClick(BuildContext context) async {
    // AppRoute.locationSearch.navigateBackStack(context,
    //     extra: VMILocationSelectCallbackHelper(
    //         onSelectVMILocation: (location) {
    //           context
    //               .read<CurrentLocationCubit>()
    //               .onLocationSelectEvent(location);
    //           context.read<CurrentLocationCubit>().onLoadLocationData();

    //           // ignore: avoid_print
    //           print("Location Selected: $location");
    //         },
    //         locationSearchType: LocationSearchType.vmi));
  }
}
