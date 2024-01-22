import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends BaseDynamicContentScreen {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountPageBloc, AccountPageState>(
      builder: (context, state) {
        switch (state) {
          case AccountPageInitialState():
          case AccountPageLoadingState():
            return const Center(child: CircularProgressIndicator());
          case AccountPageLoadedState():
            return Scaffold(
                body: ListView(
              children: buildContentWidgets(state.pageWidgets),
            ));
          case AccountPageFailureState():
            return const Center(child: Text('Failed Loading Account'));
          default:
            return const Center(child: Text('Failed Loading Account'));
        }
      },
    );
  }
}
