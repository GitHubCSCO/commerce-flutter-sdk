part of 'search_page_cms_bloc.dart';

abstract class SearchPageCmsState {}

class SearchPageCmsInitialState extends SearchPageCmsState {}

class SearchPageCmsLoadingState extends SearchPageCmsState {}

class SearchPageCmsLoadedState extends SearchPageCmsState {
  final List<WidgetEntity> pageWidgets;
  SearchPageCmsLoadedState({required this.pageWidgets});
}

class SearchPageCmsFailureState extends SearchPageCmsState {
  final String error;

  SearchPageCmsFailureState(this.error);
}
