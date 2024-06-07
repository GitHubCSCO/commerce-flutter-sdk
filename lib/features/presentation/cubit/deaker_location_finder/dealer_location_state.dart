import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class DealerLocationState {}

class DealerLocationInitialState extends DealerLocationState {}

class DealerLocationLoadingState extends DealerLocationState {}

class DealerLocationLoadedState extends DealerLocationState {
  final List<Dealer> dealers;

  DealerLocationLoadedState({required this.dealers});
}

class DealerLocationFailureState extends DealerLocationState {
  final String message;

  DealerLocationFailureState({required this.message});
}
