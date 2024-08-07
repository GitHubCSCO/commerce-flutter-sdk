part of 'show_hide_pricing_bloc.dart';

abstract class ShowHidePricingState extends Equatable {
  const ShowHidePricingState();
}

class ShowHidePricingInitial extends ShowHidePricingState {
  final bool value;

  const ShowHidePricingInitial(this.value);

  @override
  List<Object> get props => [value];
}

class ShowHidePricingChanged extends ShowHidePricingState {
  final bool value;

  const ShowHidePricingChanged(this.value);

  @override
  List<Object> get props => [value];
}
