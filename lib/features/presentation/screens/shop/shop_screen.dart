import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends BaseDynamicContentScreen {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopPageBloc, ShopPageState>(
      builder: (context, state) {
        switch(state) {
          case ShopPageInitialState():
          case ShopPageLoadingState():
            return const Center(child: CircularProgressIndicator());
          case ShopPageLoadedState():
            return Scaffold(
                body: ListView(
                  children: buildContentWidgets(state.pageWidgets),
                )
            );
          case ShopPageFailureState():
            return const Center(child: Text('Failed Loading Shop'));
          default:
            return const Center(child: Text('Failed Loading Shop'));
        }
      },
    );
  }

}
