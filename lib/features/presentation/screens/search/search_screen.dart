import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends BaseDynamicContentScreen {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageBloc, SearchPageState>(
      builder: (context, state) {
        switch(state) {
          case SearchPageInitialState():
          case SearchPageLoadingState():
            return const Center(child: CircularProgressIndicator());
          case SearchPageLoadedState():
            return Scaffold(
                body: ListView(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      child: Input(
                        hintText: LocalizationConstants.search,
                        onTapOutside: (context) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      ),
                    ),
                    ...buildContentWidgets(state.pageWidgets),
                  ],
                )
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
