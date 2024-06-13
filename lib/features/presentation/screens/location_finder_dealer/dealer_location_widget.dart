import 'package:commerce_flutter_app/features/presentation/cubit/deaker_location_finder/dealer_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/deaker_location_finder/dealer_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/location_finder_dealer/dealer_location_widget_item.dart';
import 'package:commerce_flutter_app/features/presentation/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealerLocationWidget extends StatelessWidget {
  const DealerLocationWidget();

  @override
  Widget build(BuildContext context) {
    context.read<DealerLocationCubit>().loadDealersLocation();
    return MultiBlocListener(
        listeners: [
          BlocListener<DealerLocationCubit, DealerLocationState>(
            listener: (context, state) {
              if (state is DealerLocationLoadedState) {
                context
                    .read<GMapCubit>()
                    .updateMarkersFromDealerLocationFinder(state.dealers);
              }
            },
          ),
        ],
        child: BlocBuilder<DealerLocationCubit, DealerLocationState>(
          builder: (context, state) {
            if (state is DealerLocationInitialState) {
              return Container();
            } else if (state is DealerLocationLoadingState) {
              return Container(
                child: CircularProgressIndicator(),
              );
            } else if (state is DealerLocationLoadedState) {
              return Column(
                children: [
                  const MapWidget(),
                  Expanded(
                    child: ListView(
                      children: state.dealers
                          .map((e) => DealerLocationWidgetItem(
                                dealerData: e,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
