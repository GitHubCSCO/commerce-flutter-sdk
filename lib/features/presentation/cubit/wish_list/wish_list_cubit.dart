import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit()
      : super(
          const WishListState(
            sortOrder: WishListSortOrder.modifiedOnDescending,
            status: WishListStatus.initial,
            wishLists: WishListCollectionEntity(
              wishListCollection: [],
            ),
          ),
        );
}
