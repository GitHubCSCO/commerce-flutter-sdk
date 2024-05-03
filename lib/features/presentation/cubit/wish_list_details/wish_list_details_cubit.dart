import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'wish_list_details_state.dart';

class WishListDetailsCubit extends Cubit<WishListDetailsState> {
  final WishListDetailsUsecase _wishListDetailsUsecase;

  WishListDetailsCubit({required WishListDetailsUsecase wishListDetailsUsecase})
      : _wishListDetailsUsecase = wishListDetailsUsecase,
        super(WishListDetailsInitial());
}
