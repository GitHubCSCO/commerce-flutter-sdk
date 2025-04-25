import 'package:commerce_flutter_sdk/features/presentation/cubit/dealer_location_finder/dealer_location_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/dealer_location_finder/dealer_location_state.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/location_finder_dealer/dealer_location_widget_item.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/error_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/map_widget.dart';
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DealerLocationLoadedState) {
            return Column(
              children: [
                const MapWidget(),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollEndNotification &&
                          scrollNotification.metrics.extentAfter == 0) {
                        // Load more dealers when scrolled to bottom
                        context.read<DealerLocationCubit>().loadMoreDealers();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: state.dealers.length +
                          (context.read<DealerLocationCubit>().isLoadingMore
                              ? 1
                              : 0), // Extra item for loader if loading more
                      itemBuilder: (context, index) {
                        if (index < state.dealers.length) {
                          return DealerLocationWidgetItem(
                            dealerData: state.dealers[index],
                          );
                        } else {
                          // Show loader when loading more data
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return OptiErrorWidget(onRetry: () async {
              await context.read<DealerLocationCubit>().loadDealersLocation();
            });
          }
        },
      ),
    );
  }
}
