part of 'cms_cubit.dart';

abstract class CmsState {}

class CmsInitialState extends CmsState {}

class CmsLoadingState extends CmsState {}

class CmsLoadedState extends CmsState {
  final List<WidgetEntity> widgetEntities;

  CmsLoadedState({required this.widgetEntities});
}

class CmsFailureState extends CmsState {}

