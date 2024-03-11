import 'package:flutter_bloc/flutter_bloc.dart';

part 'pull_to_refresh_event.dart';
part 'pull_to_refresh_state.dart';

class PullToRefreshBloc extends Bloc<PullToRefreshEvent, PullToRefreshState> {
  PullToRefreshBloc() : super(PullToRefreshLoadState()) {
    on<PullToRefreshEvent>((event, emit) {
      if (event is PullToRefreshInitialEvent) {
        emit(PullToRefreshLoadState());
      }
    });
  }
}
