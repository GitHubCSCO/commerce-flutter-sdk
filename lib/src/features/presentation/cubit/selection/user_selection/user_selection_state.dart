part of 'user_selection_cubit.dart';

enum UserStatus {
  initial,
  loading,
  success,
  failiure,
}

class UserSelectionState extends Equatable {
  final UserStatus status;
  final List<CatalogTypeDto>? userList;
  final String? selectedId;

  const UserSelectionState({
    this.status = UserStatus.initial,
    this.userList,
    this.selectedId,
  });

  @override
  List<Object> get props => [
        status,
        userList ?? [],
        selectedId ?? '',
      ];

  UserSelectionState copyWith({
    UserStatus? status,
    List<CatalogTypeDto>? userList,
    String? selectedId,
  }) {
    return UserSelectionState(
      status: status ?? this.status,
      userList: userList ?? this.userList,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
