import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'wish_list_tags_controller_state.dart';

class WishListTagsControllerCubit extends Cubit<WishListTagsControllerState> {
  final WishListDetailsUsecase _wishListDetailsUsecase;
  WishListTagsControllerCubit(
      {required WishListDetailsUsecase wishListDetailsUsecase})
      : _wishListDetailsUsecase = wishListDetailsUsecase,
        super(
          const WishListTagsControllerInitial(),
        );

  void initialize({
    required List<WishListTagEntity> wishListTags,
  }) {
    emit(
      WishListTagsControllerInitial(wishListTags: wishListTags),
    );
  }

  void startEditing() {
    emit(
      WishListTagsControllerEditing(
        wishListTags: (state as WishListTagsControllerInitial).wishListTags,
        deletedTags: const [],
        addedTags: const [],
      ),
    );
  }

  void addTag(WishListTagEntity tag) {
    if (state is WishListTagsControllerEditing) {
      final currentState = state as WishListTagsControllerEditing;
      final updatedTags =
          List<WishListTagEntity>.from(currentState.addedTags ?? [])..add(tag);
      emit(
        WishListTagsControllerEditing(
          wishListTags: currentState.wishListTags,
          deletedTags: currentState.deletedTags,
          addedTags: updatedTags,
        ),
      );
    }
  }

  void removeTag(WishListTagEntity tag) {
    if (state is WishListTagsControllerEditing) {
      if (tag.id == null) {
        // delete the tag from added tags
        final currentState = state as WishListTagsControllerEditing;
        final updatedTags =
            List<WishListTagEntity>.from(currentState.addedTags ?? [])
              ..removeWhere((element) => element.id == tag.id);
        emit(
          WishListTagsControllerEditing(
            wishListTags: currentState.wishListTags,
            deletedTags: currentState.deletedTags,
            addedTags: updatedTags,
          ),
        );
        return;
      }

      final currentState = state as WishListTagsControllerEditing;
      final updatedTags =
          List<WishListTagEntity>.from(currentState.deletedTags ?? [])
            ..add(tag);

      // remove the tag from wishListTags
      final updatedWishListTags =
          List<WishListTagEntity>.from(currentState.wishListTags ?? [])
            ..removeWhere((element) => element.id == tag.id);

      emit(
        WishListTagsControllerEditing(
          wishListTags: updatedWishListTags,
          deletedTags: updatedTags,
          addedTags: currentState.addedTags,
        ),
      );
    }
  }

  Future<void> saveTags({required String wishListId}) async {
    if (state is WishListTagsControllerEditing) {
      final currentState = state as WishListTagsControllerEditing;
      final wishListTags = currentState.wishListTags;
      final addedTags = currentState.addedTags ?? [];
      final deletedTags = currentState.deletedTags ?? [];

      emit(
        WishListTagsControllerLoading(
          wishListTags: wishListTags,
        ),
      );

      final result = await _wishListDetailsUsecase.updateWishListTags(
        wishListId: wishListId,
        deletedTags: deletedTags,
        addedTags: addedTags,
      );

      if (result == null) {
        emit(
          const WishListTagsControllerError(
            errorMessage: 'Failed to update tags',
          ),
        );
      }

      return emit(
        WishListTagsControllerSuccess(
          wishListTags: result?.wishListTags,
        ),
      );
    }
  }
}
