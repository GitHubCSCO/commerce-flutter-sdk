part of 'language_bloc.dart';

abstract class LanguageEvent {}

class LanguageLoadEvent extends LanguageEvent {}

class LanguageChangeEvent extends LanguageEvent {
  final Language language;
  LanguageChangeEvent({
    required this.language,
  });
}
