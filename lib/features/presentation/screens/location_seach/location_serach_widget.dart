import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/location_search_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/dealer_location_finder/dealer_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/billto_shipto/pick_up_location_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/location_finder_dealer/dealer_location_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_location_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationSearchScreen extends StatelessWidget {
  final LocationSearchType locationSearchType;
  final WarehouseEntity? selectedPickupWarehouse;
  final void Function(CurrentLocationDataEntity)? onVMILocationUpdated;
  final void Function(WarehouseEntity)? onWarehouseLocationSelected;
  const LocationSearchScreen(
      {super.key,
      this.onVMILocationUpdated,
      this.selectedPickupWarehouse,
      required this.locationSearchType,
      this.onWarehouseLocationSelected});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocationSearchBloc>(
              create: (context) => sl<LocationSearchBloc>()),
          BlocProvider<VMILocationBloc>(
              create: (context) =>
                  sl<VMILocationBloc>()..add(LoadVMILocationsEvent())),
          BlocProvider<GMapCubit>(create: (context) => sl<GMapCubit>()),
          BlocProvider<DealerLocationCubit>(
              create: (context) => sl<DealerLocationCubit>()),
          BlocProvider<PickupLocationBloc>(
              create: (context) => sl<PickupLocationBloc>()
                ..add(LoadPickUpLocationsEvent(
                    selectedPickupWarehouse: selectedPickupWarehouse)))
        ],
        child: LocationSearchPage(
          onVMILocationUpdated: onVMILocationUpdated,
          locationSearchType: locationSearchType,
          onWarehouseLocationSelected: onWarehouseLocationSelected,
        ));
  }
}

class LocationSearchPage extends StatelessWidget {
  final void Function(CurrentLocationDataEntity)? onVMILocationUpdated;
  final void Function(WarehouseEntity)? onWarehouseLocationSelected;
  final LocationSearchType locationSearchType;
  final WarehouseEntity? selectedPickupWarehouse;
  LocationSearchPage(
      {super.key,
      this.selectedPickupWarehouse,
      this.onVMILocationUpdated,
      required this.locationSearchType,
      this.onWarehouseLocationSelected});
  final textEditingController = TextEditingController();

  String getTitle() {
    switch (locationSearchType) {
      case LocationSearchType.vmi:
        return 'VMI';
      case LocationSearchType.locationFinder:
        return 'Location Finder';
      case LocationSearchType.pickUpLocation:
        return 'Pick Up Location';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: Text(getTitle()),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Input(
                    hintText: LocalizationConstants.search.localized(),
                    suffixIcon: IconButton(
                      icon: const SvgAssetImage(
                        assetName: AssetConstants.iconClear,
                        semanticsLabel: 'search query clear icon',
                        fit: BoxFit.fitWidth,
                      ),
                      onPressed: () {
                        textEditingController.clear();
                        context.closeKeyboard();
                        context
                            .read<LocationSearchBloc>()
                            .add(LocationSearchInitialEvent());
                      },
                    ),
                    onTapOutside: (p0) => context.closeKeyboard(),
                    textInputAction: TextInputAction.search,
                    focusListener: (bool hasFocus) {
                      if (hasFocus) {
                        context
                            .read<LocationSearchBloc>()
                            .add(LocationSeachHistoryLoadEvent());
                      }
                    },
                    onChanged: (String searchQuery) {},
                    onSubmitted: (String query) {
                      if (query.isNotEmpty) {
                        context.read<LocationSearchBloc>().add(
                            LocationSearchLoadEvent(
                                searchQuery: query, pageType: ""));
                      } else {
                        context
                            .read<LocationSearchBloc>()
                            .add(LocationSearchInitialEvent());
                      }
                    },
                    controller: textEditingController,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: MultiBlocListener(
            listeners: [
              BlocListener<LocationSearchBloc, LoactionSearchState>(
                listener: (context, state) {
                  if (state is LocationSearchLoadedState) {
                    textEditingController.text =
                        state.searchedLocation?.formattedName ?? "";

                    if (locationSearchType == LocationSearchType.vmi) {
                      context.read<VMILocationBloc>().add(
                          UpdateSearchPlaceEvent(
                              seachPlace: state.searchedLocation));
                      context
                          .read<VMILocationBloc>()
                          .add(LoadVMILocationsEvent());
                    } else if (locationSearchType ==
                        LocationSearchType.locationFinder) {
                      context
                          .read<DealerLocationCubit>()
                          .updateSeachPlaceForDealer(state.searchedLocation);
                    } else if (locationSearchType ==
                        LocationSearchType.pickUpLocation) {
                      context.read<PickupLocationBloc>().add(
                          LoadSearchedPickUpLocationsEvent(
                              searchedLocation: state.searchedLocation));
                    }
                  } else if (state is LocationSearchFailureState) {
                    if (locationSearchType == LocationSearchType.vmi) {
                      context.read<VMILocationBloc>().add(
                          SearchVMILocationFromListEvent(
                              searchKey: textEditingController.text));
                    }
                  }
                },
              ),
            ],
            child: BlocBuilder<LocationSearchBloc, LoactionSearchState>(
              builder: (_, state) {
                if (state is LocationSearchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LocationSearchInitialState) {
                  switch (locationSearchType) {
                    case LocationSearchType.vmi:
                      {
                        return VMILocationScreen(
                          onLocationSelected:
                              (CurrentLocationDataEntity locationData) {
                            onVMILocationUpdated!(locationData);
                          },
                        );
                      }
                    case LocationSearchType.locationFinder:
                      {
                        return const DealerLocationWidget();
                      }
                    case LocationSearchType.pickUpLocation:
                      return PickUpLocationScreen(
                          onWarehouseLocationSelected: (locationData) {
                        onWarehouseLocationSelected!(locationData);
                      });
                  }
                } else if (state is LocationSearchLoadedState) {
                  switch (locationSearchType) {
                    case LocationSearchType.vmi:
                      {
                        return VMILocationScreen(
                          onLocationSelected:
                              (CurrentLocationDataEntity locationData) {
                            onVMILocationUpdated!(locationData);
                          },
                        );
                      }
                    case LocationSearchType.locationFinder:
                      {
                        return const DealerLocationWidget();
                      }
                    case LocationSearchType.pickUpLocation:
                      return PickUpLocationScreen(
                          onWarehouseLocationSelected: (locationData) {
                        onWarehouseLocationSelected!(locationData);
                      });
                  }
                } else if (state is LocationSearchFocusState) {
                  return Container();
                } else if (state is LocationSearchFailureState) {
                  if (locationSearchType == LocationSearchType.vmi) {
                    return VMILocationScreen(
                      onLocationSelected:
                          (CurrentLocationDataEntity locationData) {
                        onVMILocationUpdated!(locationData);
                      },
                    );
                  } else {
                    return const Center(child: Text('No results found'));
                  }
                } else if (state is LocationSearchHistoryLoadedState) {
                  return (state.searchHistory.isEmpty)
                      ? Text(LocalizationConstants.searchNoHistoryAvailable
                          .localized())
                      : buildSearchHistoryList(state);
                } else {
                  return Container();
                }
              },
            ),
          ))
        ],
      ),
    );
  }

  Container buildSearchHistoryList(LocationSearchHistoryLoadedState state) {
    return Container(
        child: ListView.builder(
      itemCount: state.searchHistory.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(state.searchHistory[index]),
          onTap: () {
            textEditingController.text = state.searchHistory[index];
            context.read<LocationSearchBloc>().add(LocationSearchLoadEvent(
                searchQuery: state.searchHistory[index], pageType: ""));
          },
        );
      },
    ));
  }
}
