import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_main/vmi_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_main/vmi_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_main/vmi_page_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/location_note/location_note_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/previous_orders_cubit/previous_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VMIScreen extends StatelessWidget {
  const VMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider(
        create: (context) => sl<CurrentLocationCubit>(),
      ),
      BlocProvider(
        create: (context) => sl<PreviousOrdersCubit>(),
      ),
      BlocProvider(
        create: (context) => sl<LocationSearchBloc>(),
      ),
      BlocProvider(
        create: (context) => sl<LocationNoteCubit>()..loadLocationNote(),
      ),
      BlocProvider<VMIPageBloc>(
          create: (context) =>
              sl<VMIPageBloc>()..add(const VMIPageLoadEvent())),
    ], child: const VMIPage());
  }
}

class VMIPage extends BaseDynamicContentScreen {
  const VMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text('VMI'),
        centerTitle: false,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CurrentLocationCubit, CurrentLocationState>(
              listener: (_, state) {
            if (state is CurrentLocationLoadedState) {
              context.read<PreviousOrdersCubit>().loadPreviousOrders();
              context.read<LocationNoteCubit>().loadLocationNote();
            }
          }),
          BlocListener<VMIPageBloc, VMIPageState>(
            listener: (_, state) {
              switch (state) {
                case VMIPageLoadingState():
                  context.read<CmsCubit>().loading();
                case VMIPageLoadedState():
                  context.read<CmsCubit>().buildCMSWidgets(state.pageWidgets);
                  context
                      .read<VMIPageBloc>()
                      .add(const VMILoacationLoadEvent());
                  context.read<PreviousOrdersCubit>().loadPreviousOrders();
                case VMILoacationLoadedState():
                  context.read<CurrentLocationCubit>().onLoadLocationData();
                case VMIPageFailureState():
                  context.read<CmsCubit>().failedLoading();
              }
            },
          ),
        ],
        child: BlocBuilder<CmsCubit, CmsState>(
          builder: (context, state) {
            switch (state) {
              case CmsInitialState():
              case CmsLoadingState():
                return const Center(child: CircularProgressIndicator());
              case CmsLoadedState():
                return Scaffold(
                    backgroundColor: OptiAppColors.backgroundGray,
                    body: ListView(
                      children: buildContentWidgets(state.widgetEntities),
                    ));
              default:
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(
                      child: Center(
                        child: Text(LocalizationConstants.errorLoadingShop.localized()),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
