part of 'language_bloc.dart';

abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {}

class LanguageListLoaded extends LanguageState {

  final List<Language>? languages;
  final Language? selectedLanguage;

  LanguageListLoaded(this.languages, this.selectedLanguage);

}

class LanguageFailedToLoad extends LanguageState {
  final String error;
  LanguageFailedToLoad(this.error);
}