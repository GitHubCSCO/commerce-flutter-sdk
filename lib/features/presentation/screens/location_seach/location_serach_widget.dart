import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({super.key, this.onVMILocationUpdated});

  final void Function(CurrentLocationDataEntity)? onVMILocationUpdated;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocationSearchBloc>(
              create: (context) => sl<LocationSearchBloc>()),
          BlocProvider<VMILocationBloc>(
              create: (context) =>
                  sl<VMILocationBloc>()..add(LoadVMILocationsEvent())),
          BlocProvider<GMapCubit>(create: (context) => sl<GMapCubit>())
        ],
        child: LocationSearchPage(
          onVMILocationUpdated: onVMILocationUpdated,
        ));
  }
}

class LocationSearchPage extends StatelessWidget {
  final void Function(CurrentLocationDataEntity)? onVMILocationUpdated;

  LocationSearchPage({super.key, this.onVMILocationUpdated});
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text('VMI'),
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
                    hintText: LocalizationConstants.search,
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        AssetConstants.iconClear,
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
                      } else {
                        // context
                        //     .read<LocationSearchBloc>()
                        //     .add(LocationSearchInitialEvent());
                      }
                    },
                    onChanged: (String searchQuery) {},
                    onSubmitted: (String query) {
                      context.read<LocationSearchBloc>().add(
                          LocationSearchLoadEvent(
                              searchQuery: query, pageType: ""));
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
                    context.read<VMILocationBloc>().add(UpdateSearchPlaceEvent(
                        seachPlace: state.searchedLocation));
                    context
                        .read<VMILocationBloc>()
                        .add(LoadVMILocationsEvent());
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
                  return VMILocationScreen(
                    onLocationSelected:
                        (CurrentLocationDataEntity locationData) {
                      onVMILocationUpdated!(locationData);
                    },
                  );
                } else if (state is LocationSearchLoadedState) {
                  return VMILocationScreen(
                    onLocationSelected:
                        (CurrentLocationDataEntity locationData) {
                      onVMILocationUpdated!(locationData);
                    },
                  );
                } else if (state is LocationSearchFocusState) {
                  return Container(child: Text('LocationSearchFocusState'));
                } else if (state is LocationSearchFailureState) {
                  return Container(child: Text('LocationSearchFailureState'));
                } else if (state is LocationSearchHistoryLoadedState) {
                  return (state.searchHistory.length == 0)
                      ? Container(child: Text("No History Found"))
                      : Container(
                          child: ListView.builder(
                          itemCount: state.searchHistory.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.searchHistory[index]),
                              onTap: () {
                                textEditingController.text =
                                    state.searchHistory[index];
                                context.read<LocationSearchBloc>().add(
                                    LocationSearchLoadEvent(
                                        searchQuery: state.searchHistory[index],
                                        pageType: ""));
                              },
                            );
                          },
                        ));
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
}
