import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchPageBloc>(
        create: (context) => sl<SearchPageBloc>()..add(SearchPageLoadEvent()),
        child: const SearchPage());
  }
}

class SearchPage extends BaseDynamicContentScreen {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageBloc, SearchPageState>(
      builder: (context, state) {
        switch  (state) {
          case SearchPageInitialState():
          case SearchPageLoadingState():
            return const Center(child: CircularProgressIndicator());
          case SearchPageLoadedState():
            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                context.read<SearchPageBloc>().add(SearchPageLoadEvent());
              },
              child: Scaffold(
                  body: ListView(
                children: buildContentWidgets(state.pageWidgets),
              )),
            );
          case SearchPageFailureState():
            return const Center(child: Text('Failed Loading Search'));
          default:
            return const Center(child: Text('Failed Loading Search'));
        }
      },
    );
  }
}
