import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  final String userName;
  final String oldPassword;

  const ChangePasswordEntity({
    required this.userName,
    required this.oldPassword,
  });

  @override
  List<Object?> get props => [userName, oldPassword];
}
