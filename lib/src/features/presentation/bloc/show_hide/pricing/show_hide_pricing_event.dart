part of 'show_hide_pricing_bloc.dart';

abstract class ShowHidePricingEvent extends Equatable {
  const ShowHidePricingEvent();
}

class ShowHidePricingToggled extends ShowHidePricingEvent {
  final bool value;

  const ShowHidePricingToggled(this.value);

  @override
  List<Object> get props => [value];
}
