import 'package:commerce_flutter_sdk/features/domain/usecases/selection_usecase/selection_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/selection_item_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'user_selection_state.dart';

class UserSelectionCubit extends Cubit<UserSelectionState> {
  final SelectionUsecase _selectionUsecase;

  UserSelectionCubit({
    required SelectionUsecase selectionUsecase,
  })  : _selectionUsecase = selectionUsecase,
        super(const UserSelectionState());

  Future<void> initialize({
    required CatalogTypeSelectingParameter parameter,
  }) async {
    final selectedUser = parameter.currentItem;
    emit(
      UserSelectionState(
        status: UserStatus.loading,
        selectedId: selectedUser?.id,
      ),
    );

    final userList = await _selectionUsecase.getUsersList(
      removeMyself: parameter.removeMyself,
    );

    if (userList == null) {
      emit(state.copyWith(status: UserStatus.failiure));
      return;
    }

    emit(
      state.copyWith(
        status: UserStatus.success,
        userList: userList,
      ),
    );
  }

  void setSelectedUser({
    required CatalogTypeDto selectedUser,
  }) {
    emit(
      state.copyWith(
        selectedId: selectedUser.id,
      ),
    );
  }
}
