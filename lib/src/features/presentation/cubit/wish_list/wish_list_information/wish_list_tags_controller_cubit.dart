import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
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
              ..removeWhere((element) => element.tag == tag.tag);
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

  String addedTagTitle(String? tag) {
    if (tag == null) {
      return '';
    }

    tag = tag.trim();
    // Remove all punctuation marks except hyphens (-) and underscores (_)
    tag = tag.replaceAll(RegExp(r'[^\w\s\-_]'), '');

    if (tag.isEmpty) {
      return '';
    }

    if (state is WishListTagsControllerEditing) {
      final currentState = state as WishListTagsControllerEditing;
      final addedTags = currentState.addedTags ?? [];
      final existingTags = currentState.wishListTags ?? [];
      final tagToLowerCase = tag.toLowerCase();

      if (existingTags
              .any((element) => element.tag?.toLowerCase() == tagToLowerCase) ||
          addedTags
              .any((element) => element.tag?.toLowerCase() == tagToLowerCase)) {
        return '';
      }

      return tag;
    }
    return '';
  }

  Future<void> deleteSingleTag({
    required String wishListId,
    required String tagId,
  }) async {
    final currentWishListTags =
        (state as WishListTagsControllerInitial).wishListTags;

    emit(
      WishListTagsControllerLoading(
        wishListTags: currentWishListTags,
      ),
    );

    final result = await _wishListDetailsUsecase.deleteSingleTag(
      wishListId: wishListId,
      tagId: tagId,
    );

    if (result == false) {
      emit(
        const WishListTagsControllerError(
          errorMessage: 'Failed to delete tag',
        ),
      );
    }

    return emit(
      WishListTagsControllerSingleTagDeleted(
        wishListTags: currentWishListTags
            ?.where((element) => element.id != tagId)
            .toList(),
      ),
    );
  }
}
