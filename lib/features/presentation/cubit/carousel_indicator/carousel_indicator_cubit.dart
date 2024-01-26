import 'package:flutter_bloc/flutter_bloc.dart';

part 'carousel_indicator_state.dart';

class CarouselIndicatorCubit extends Cubit<CarouselIndicatorState> {
  CarouselIndicatorCubit() : super(CarouselIndicatorState(0));

  Future<void> carouselPageChange(int index) async {
    emit(CarouselIndicatorState(index));
  }

}
