import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain_change/domain_change_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _reloadShopPage(BuildContext context) {
  context.read<ShopPageBloc>().add(const ShopPageLoadEvent());
}

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopPageBloc>(
        create: (context) => sl<ShopPageBloc>()..add(const ShopPageLoadEvent()),
        child: const ShopPage());
  }
}

class ShopPage extends BaseDynamicContentScreen {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        BottomMenuWidget(),
      ]),
      body: BlocBuilder<ShopPageBloc, ShopPageState>(
        builder: (context, state) {
          switch (state) {
            case ShopPageInitialState():
            case ShopPageLoadingState():
              return const Center(child: CircularProgressIndicator());
            case ShopPageLoadedState():
              return MultiBlocListener(
                listeners: [
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      _reloadShopPage(context);
                    },
                  ),
                  BlocListener<DomainChangeCubit, DomainChangeState>(
                    listener: (context, state) {
                      if (state is DomainChangeSuccess) {
                        _reloadShopPage(context);
                      }
                    },
                  ),
                ],
                child: Scaffold(
                    body: ListView(
                  children: buildContentWidgets(state.pageWidgets),
                )),
              );
            case ShopPageFailureState():
              return const Center(child: Text('Failed Loading Shop'));
            default:
              return const Center(child: Text('Failed Loading Shop'));
          }
        },
      ),
    );
  }

  // List<ToolMenu> _getToolMenu(BuildContext context) {
  //   List<ToolMenu> list = [];
  //   list.add(ToolMenu(
  //     title: "Setting",
  //     action: () {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("Sending Message"),
  //       ));
  //     }
  //   ));
  //   return list;
  // }
}
