import 'package:commerce_flutter_app/features/domain/usecases/language_usecase/language_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'language_state.dart';
part 'language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageUsecase _languageUsecase;
  List<Language>? languages;

  LanguageBloc({required LanguageUsecase languageUsecase})
      : _languageUsecase = languageUsecase,
        super(LanguageInitial()) {
    on<LanguageLoadEvent>(_onLanguageLoadEvent);
    on<LanguageListLoadEvent>(_onLanguageListLoadEvent);
    on<LanguageChangeEvent>(_onLanguageChangeEvent);
  }

  Future<void> _onLanguageLoadEvent(
      LanguageLoadEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());
    var result = await _languageUsecase.loadCurrentLanguage();
    switch (result) {
      case Success(value: final data):
        if (data == true) {
          emit(LanguageLoaded());
        } else {
          emit(LanguageFailedToLoad("Language could not be loaded."));
        }
        break;
      case Failure(errorResponse: final errorResponse):
        await _languageUsecase.trackError(errorResponse);
        emit(LanguageFailedToLoad(errorResponse.extractErrorMessage() ??
            "Language could not be loaded."));
        break;
    }
  }

  Future<void> _onLanguageListLoadEvent(
      LanguageListLoadEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());
    var result = await _languageUsecase.loadLanguageList();
    switch (result) {
      case Success(value: final data):
        if ((data?.languages ?? []).isNotEmpty) {
          languages = data?.languages;
          var language = _languageUsecase.getCurrentLanguage();
          emit(LanguageListLoaded(languages, language));
        } else {
          emit(LanguageFailedToLoad("Language could not be loaded."));
        }
        break;
      case Failure(errorResponse: final errorResponse):
        await _languageUsecase.trackError(errorResponse);
        emit(LanguageFailedToLoad(errorResponse.extractErrorMessage() ??
            "Language could not be loaded."));
        break;
    }
  }

  Future<void> _onLanguageChangeEvent(
      LanguageChangeEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());
    var result = await _languageUsecase.changeLanguage(event.language);
    switch (result) {
      case Success(value: final data):
        if (data == true) {
          _languageUsecase.loadDefaultSiteMessage();
          emit(LanguageChanged());
          var language = _languageUsecase.getCurrentLanguage();
          emit(LanguageListLoaded(languages, language));
        } else {
          emit(LanguageFailedToLoad("Language could not be changed."));
        }
        break;
      case Failure(errorResponse: final errorResponse):
        await _languageUsecase.trackError(errorResponse);
        emit(LanguageFailedToLoad(errorResponse.extractErrorMessage() ??
            "Language could not be changed."));
        break;
    }
  }
}
