part of 'quick_order_bloc.dart';

abstract class QuickOrderEvent {}

class QuickOrderStartSearchEvent extends QuickOrderEvent {}

class QuickOrderEndSearchEvent extends QuickOrderEvent {}