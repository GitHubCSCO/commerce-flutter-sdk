import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_page_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VMIScreen extends StatelessWidget {
  const VMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider<VMIPageBloc>(
        create: (context) => sl<VMIPageBloc>()..add(const VMIPageLoadEvent()),
      ),
    ], child: const VMIPage());
  }
}

class VMIPage extends BaseDynamicContentScreen {
  const VMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      // appBar: AppBar(actions: <Widget>[
      //   BottomMenuWidget(websitePath: websitePath),
      // ], backgroundColor: Theme.of(context).colorScheme.surface),
      body: MultiBlocListener(
        listeners: [
          BlocListener<VMIPageBloc, VMIPageState>(
            listener: (context, state) {
              switch (state) {
                case VMIPageLoadingState():
                  context.read<CmsCubit>().loading();
                case VMIPageLoadedState():
                  context.read<CmsCubit>().buildCMSWidgets(state.pageWidgets);
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
                return const CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(
                      child: Center(
                        child: Text(LocalizationConstants.errorLoadingShop),
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
