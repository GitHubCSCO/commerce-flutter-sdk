import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/exceptions/language_exceptions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/localization_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LocalizationService implements ILocalizationService {
  static const String _translationDictionaryKey = "translation_dictionary";

  final Map<String, String> _translationDictionary = {};

  Language? _currentLanguage;

  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;
  final ICoreServiceProvider _coreServiceProvider;

  LocalizationService({
    required ICommerceAPIServiceProvider commerceAPIServiceProvider,
    required ICoreServiceProvider coreServiceProvider,
  })  : _commerceAPIServiceProvider = commerceAPIServiceProvider,
        _coreServiceProvider = coreServiceProvider;

  @override
  Future<Result<bool, ErrorResponse>> changeLanguage(Language? language) async {
    if (language == null) {
      return Failure(ErrorResponse(
          exception: ChangeLanguageException(
              message: "Provided language is null in changeLanguage")));
    }
    var translationDictionaryLoaded = await loadTranslationDictionary(language);
    if (translationDictionaryLoaded) {
      var sessionResult = await _commerceAPIServiceProvider
          .getSessionService()
          .getCurrentSession();
      switch (sessionResult) {
        case Success(value: final session):
          {
            if (session == null) {
              return Failure(ErrorResponse(
                  exception: ChangeLanguageException(
                      message: "Session is null during changeLanguage")));
            } else {
              session.language = language;
              var patchSessionResult = await _commerceAPIServiceProvider
                  .getSessionService()
                  .patchSession(session);
              switch (patchSessionResult) {
                case Success(value: final patchedSession):
                  {
                    if (patchedSession == null ||
                        patchedSession.language?.id != language.id) {
                      return Failure(ErrorResponse(
                          exception: ChangeLanguageException(
                              message:
                                  "Session could not be patched with languageCode: ${language.languageCode} ${language.toJson().toString()}")));
                    }
                    _currentLanguage = language;
                  }
                case Failure(errorResponse: final errorResponse):
                  {
                    return Failure(errorResponse);
                  }
              }
            }
          }
        case Failure(errorResponse: final errorResponse):
          {
            return Failure(errorResponse);
          }
      }
    }
    return const Success(true);
  }

  @override
  Language? getCurrentLanguage() {
    return _currentLanguage;
  }

  /// Loads the current language setting.
  ///
  /// Throws a [LoadLanguageException] if the session cannot be loaded.
  @override
  Future<Result<bool, ErrorResponse>> loadCurrentLanguage() async {
    var sessionResult = await _commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();
    switch (sessionResult) {
      case Success(value: final session):
        {
          if (session == null) {
            return Failure(ErrorResponse(
                exception: LoadLanguageException(
                    message: "Could not load session to get the language")));
          } else {
            var translationDictionaryLoaded =
                await loadTranslationDictionary(session.language);
            if (translationDictionaryLoaded) {
              _currentLanguage = session.language;
            } else {
              await loadPersistedTranslationDictionaryIfAvailable();
            }
            return const Success(true);
          }
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<void> removeCurrentLanguage() async {
    await _commerceAPIServiceProvider
        .getCacheService()
        .removePersistedData(_translationDictionaryKey);
    _translationDictionary.clear();
    _currentLanguage = null;
  }

  Future<void> loadPersistedTranslationDictionaryIfAvailable() async {
    var persistedTranslationDictionary = await _commerceAPIServiceProvider
        .getCacheService()
        .loadPersistedData<Map<String, String>>(_translationDictionaryKey);
    if (persistedTranslationDictionary != null &&
        persistedTranslationDictionary.isNotEmpty) {
      _translationDictionary.clear();
      _translationDictionary.addAll(persistedTranslationDictionary);
    }
  }

  Future<bool> loadTranslationDictionary(Language? language) async {
    bool isFetched = false;
    _translationDictionary.clear();

    int count = 0;
    int maxLength = _commerceAPIServiceProvider
        .getTranslationService()
        .getMaxLengthOfTranslationText();
    var sbFieldValue = StringBuffer();

    for (var k in LocalizationConstants.values) {
      count++;
      if (sbFieldValue.length + k.keyword.length >= maxLength) {
        //remove the last character ',' from string buffer
        var modifiedString =
            sbFieldValue.toString().substring(0, sbFieldValue.length - 1);
        bool result = await fetchTranslations(language, modifiedString, count);
        isFetched = result ? result : isFetched;
        sbFieldValue.clear();
        count = 1;
      }
      sbFieldValue.write(k.keyword);
      sbFieldValue.write(",");
    }

    if (sbFieldValue.length > 1) {
      var modifiedString =
          sbFieldValue.toString().substring(0, sbFieldValue.length - 1);
      bool result = await fetchTranslations(language, modifiedString, count);
      isFetched = result ? result : isFetched;
    }

    await _commerceAPIServiceProvider
        .getCacheService()
        .persistData(_translationDictionaryKey, _translationDictionary);

    return isFetched;
  }

  Future<bool> fetchTranslations(
      Language? language, String keywords, int pageSize) async {
    bool isFetched = false;

    var translationParameters = TranslationQueryParameters(
      languageCode: language?.languageCode,
      source: 'Label',
      keyword: keywords,
      pageSize: pageSize,
    );

    var result = await _commerceAPIServiceProvider
        .getTranslationService()
        .getTranslations(parameters: translationParameters);

    switch (result) {
      case Success(value: final value):
        {
          if (value == null) {
            await _coreServiceProvider.getTrackingService().trackError(
                GetTranslationException(
                    message:
                        "Could not load translation for language (${language?.languageCode}) with $keywords"));
          } else {
            if (value.translationDictionaries != null) {
              for (var item in value.translationDictionaries!) {
                if (item.keyword.isNullOrEmpty == false &&
                    item.translation.isNullOrEmpty == false) {
                  _translationDictionary.update(
                      item.keyword!, (value) => item.translation!,
                      ifAbsent: () => item.translation!);
                }
              }
              isFetched = true;
            }
          }
        }
      case Failure(errorResponse: final errorResponse):
        {
          await _coreServiceProvider
              .getTrackingService()
              .trackError(errorResponse);
        }
    }

    return isFetched;
  }

  @override
  Map<String, String>? get translationDictionary => _translationDictionary;
}
