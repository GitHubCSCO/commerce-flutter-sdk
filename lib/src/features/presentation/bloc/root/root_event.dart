part of 'root_bloc.dart';

abstract class RootEvent {}

class RootInitialEvent extends RootEvent {}

class RootHidePricingInventoryEvent extends RootEvent {}

class RootConfigChangeEvent extends RootEvent {}

class RootCartUpdateEvent extends RootEvent {}

class RootInitiateSearchEvent extends RootEvent {
  final String query;
  RootInitiateSearchEvent(this.query);
}

class RootSearchProductEvent extends RootEvent {
  final String query;
  RootSearchProductEvent(this.query);
}

class RootAnalyticsEvent extends RootEvent {
  final AnalyticsEvent analyticsEvent;
  RootAnalyticsEvent(this.analyticsEvent);
}

class RootTelemetryEvent extends RootEvent {
  final TelemetryEvent telemetryEvent;
  RootTelemetryEvent(this.telemetryEvent);
}

class RootOrderHistoryInitialEvent extends RootEvent {}
