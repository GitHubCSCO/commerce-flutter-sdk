part of 'root_bloc.dart';

abstract class RootEvent {}

class RootInitialEvent extends RootEvent {}

class RootHidePricingInventoryEvent extends RootEvent {}

class RootConfigChangeEvent extends RootEvent {}

class RootCartUpdateEvent extends RootEvent {}
