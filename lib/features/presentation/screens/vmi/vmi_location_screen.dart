import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/vmi_location_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_location_widget_item.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VMILocationScreen extends StatefulWidget {
  final Function(CurrentLocationDataEntity) onLocationSelected;

  const VMILocationScreen({super.key, required this.onLocationSelected});

  @override
  _VMILocationScreenState createState() => _VMILocationScreenState();
}

class _VMILocationScreenState extends State<VMILocationScreen> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<VMILocationBloc>().add(LoadMoreVMILocationsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VMILocationBloc, VMILocationState>(
          listener: (_, state) {
            var searchedLocation = context.read<VMILocationBloc>().seachPlace;
            if (state is VMILocationLoadedState) {
              if (searchedLocation == null) {
                context
                    .read<GMapCubit>()
                    .updateMarkersFromVMI(state.currentLocationDataEntityList);
                if (_scrollController.hasClients &&
                    state.status == VmiLocationListStatus.itemSelected) {
                  _scrollController.jumpTo(0);
                } // Scroll to the top when new data is loaded
              } else {
                context.read<GMapCubit>().onSeachPlaceMarked(searchedLocation);
              }
            }
          },
        ),
      ],
      child: BlocBuilder<VMILocationBloc, VMILocationState>(
        builder: (_, state) {
          if (state is VMILocationInitialState) {
            return const Center(
              child: Text('VMILocationInitialState'),
            );
          } else if (state is VMILocationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is VMILocationLoadedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MapWidget(),
                Visibility(
                  visible: state.currentLocationDataEntityList.isEmpty,
                  child: const Text("No results found"),
                ),
                Visibility(
                  visible: state.currentLocationDataEntityList.isNotEmpty,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount:
                          state.status == VmiLocationListStatus.moreLoading
                              ? state.currentLocationDataEntityList.length + 1
                              : state.currentLocationDataEntityList.length,
                      controller:
                          _scrollController, // Attach the ScrollController here
                      itemBuilder: (context, index) {
                        if (index >=
                            state.currentLocationDataEntityList.length) {
                          return const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final locationData =
                            state.currentLocationDataEntityList[index];
                        return VMICurrentLocationWidgetItem(
                          locationData: locationData,
                          selectedLocation: state.selectedLocation,
                          isSelectionOn: true,
                        );
                      },
                    ),
                  ),
                ),
                ListInformationBottomSubmitWidget(actions: [
                  PrimaryButton(
                    text: LocalizationConstants.selectLocation,
                    onPressed: () async {
                      var selectedLocation =
                          context.read<VMILocationBloc>().selectedLocation;
                      if (selectedLocation != null) {
                        context.read<VMILocationBloc>().add(
                            SaveVmiLocationEvent(
                                selectedLocation: selectedLocation));
                        widget.onLocationSelected(selectedLocation);
                      }
                      context.pop();
                    },
                  ),
                ]),
              ],
            );
          } else {
            return const Center(child: Text('Error loading location data'));
          }
        },
      ),
    );
  }
}
