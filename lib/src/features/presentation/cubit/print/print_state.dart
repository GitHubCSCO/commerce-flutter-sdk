part of 'print_cubit.dart';

abstract class PrintState extends Equatable {
  const PrintState();

  @override
  List<Object?> get props => [];
}

class PrintInitial extends PrintState {}

class PrintLoading extends PrintState {}

class PrintLoaded extends PrintState {
  final Uint8List pdfData;

  const PrintLoaded(this.pdfData);

  @override
  List<Object?> get props => [pdfData];
}

class PrintError extends PrintState {
  final String message;

  const PrintError(this.message);

  @override
  List<Object?> get props => [message];
}
