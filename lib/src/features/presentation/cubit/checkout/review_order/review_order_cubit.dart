import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_order_state.dart';

class ReviewOrderCubit extends Cubit<ReviewOrderState> {
  ReviewOrderCubit() : super(ReviewOrderState());

  Future<void> onOrderConfigChange() async {
    emit(ReviewOrderState());
  }
}
