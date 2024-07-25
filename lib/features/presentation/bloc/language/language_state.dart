part of 'language_bloc.dart';

abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {}

class LanguageFailedToLoad extends LanguageState {
  final String error;
  LanguageFailedToLoad(this.error);
}

class LanguageChanged extends LanguageState {}
