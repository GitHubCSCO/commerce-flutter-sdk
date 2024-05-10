import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'wish_list_information_state.dart';

class WishListInformationCubit extends Cubit<WishListInformationState> {
  WishListInformationCubit() : super(WishListInformationInitial());
}
