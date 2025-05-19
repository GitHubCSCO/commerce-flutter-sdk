import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('Website', () {
    test('fromJson should correctly deserialize JSON to Website object', () {
      // Arrange
      final json = {
        "countriesUri": "/api/countries",
        "statesUri": "/api/states",
        "languagesUri": "/api/languages",
        "currenciesUri": "/api/currencies",
        "id": "W123",
        "name": "Sample Website",
        "description": "This is a sample website",
        "isActive": true,
        "isRestricted": false,
        "countries": {
          "countries": [
            {
              "id": "C1",
              "name": "United States",
              "abbreviation": "US",
              "states": [
                {"id": "S1", "name": "California", "abbreviation": "CA"},
                {"id": "S2", "name": "Texas", "abbreviation": "TX"}
              ]
            }
          ]
        },
        "states": {
          "states": [
            {"id": "S1", "name": "California", "abbreviation": "CA"},
            {"id": "S2", "name": "Texas", "abbreviation": "TX"}
          ]
        },
        "languages": {
          "languages": [
            {
              "id": "L1",
              "languageCode": "en",
              "cultureCode": "en-US",
              "description": "English",
              "isDefault": true,
              "isLive": true
            }
          ]
        },
        "currencies": {
          "currencies": [
            {
              "iD": "CUR1",
              "currencyCode": "USD",
              "currencySymbol": "\$",
              "description": "US Dollar",
              "isDefault": true
            }
          ]
        },
        "mobilePrimaryColor": "#FFFFFF",
        "mobilePrivacyPolicyUrl": "https://example.com/privacy",
        "mobileTermsOfUseUrl": "https://example.com/terms"
      };

      // Act
      final website = Website.fromJson(json);

      // Assert
      expect(website.countriesUri, "/api/countries");
      expect(website.statesUri, "/api/states");
      expect(website.languagesUri, "/api/languages");
      expect(website.currenciesUri, "/api/currencies");
      expect(website.id, "W123");
      expect(website.name, "Sample Website");
      expect(website.isActive, true);
      expect(website.countries?.countries?.first.name, "United States");
      expect(website.states?.states?.first.name, "California");
      expect(website.languages?.languages?.first.languageCode, "en");
      expect(website.currencies?.currencies?.first.currencyCode, "USD");
      expect(website.mobilePrimaryColor, "#FFFFFF");
      expect(website.mobilePrivacyPolicyUrl, "https://example.com/privacy");
    });

    test('toJson should correctly serialize Website object to JSON', () {
      // Arrange
      final website = Website(
        countriesUri: "/api/countries",
        statesUri: "/api/states",
        languagesUri: "/api/languages",
        currenciesUri: "/api/currencies",
        id: "W123",
        name: "Sample Website",
        description: "This is a sample website",
        isActive: true,
        isRestricted: false,
        countries: CountryCollection(countries: [
          Country(
            id: "C1",
            name: "United States",
            abbreviation: "US",
            states: [
              StateModel(id: "S1", name: "California", abbreviation: "CA"),
              StateModel(id: "S2", name: "Texas", abbreviation: "TX"),
            ],
          ),
        ]),
        states: StateCollection(states: [
          StateModel(id: "S1", name: "California", abbreviation: "CA"),
          StateModel(id: "S2", name: "Texas", abbreviation: "TX"),
        ]),
        languages: LanguageCollection(languages: [
          Language(
            id: "L1",
            languageCode: "en",
            cultureCode: "en-US",
            description: "English",
            isDefault: true,
            isLive: true,
          ),
        ]),
        currencies: CurrencyCollection(currencies: [
          Currency(
            iD: "CUR1",
            currencyCode: "USD",
            currencySymbol: "\$",
            description: "US Dollar",
            isDefault: true,
          ),
        ]),
        mobilePrimaryColor: "#FFFFFF",
        mobilePrivacyPolicyUrl: "https://example.com/privacy",
        mobileTermsOfUseUrl: "https://example.com/terms",
      );

      // Act
      final json = website.toJson();

      // Assert
      expect(json["countriesUri"], "/api/countries");
      expect(json["statesUri"], "/api/states");
      expect(json["languagesUri"], "/api/languages");
      expect(json["currenciesUri"], "/api/currencies");
      expect(json["id"], "W123");
      expect(json["name"], "Sample Website");
      expect(json["isActive"], true);
      expect(json["countries"]?["countries"]?[0]?["name"], "United States");
      expect(json["states"]?["states"]?[0]?["name"], "California");
      expect(json["languages"]?["languages"]?[0]?["languageCode"], "en");
      expect(json["currencies"]?["currencies"]?[0]?["currencyCode"], "USD");
      expect(json["mobilePrimaryColor"], "#FFFFFF");
      expect(json["mobilePrivacyPolicyUrl"], "https://example.com/privacy");
    });

    test('fromJson should handle empty JSON gracefully', () {
      // Arrange
      Map<String, dynamic> json = {};

      // Act
      final website = Website.fromJson(json);

      // Assert
      expect(website.id, isNull);
      expect(website.countriesUri, isNull);
      expect(website.states, isNull);
    });

    test('toJson should handle empty Website object gracefully', () {
      // Arrange
      final website = Website();

      // Act
      final json = website.toJson();

      // Assert
      expect(json["id"], isNull);
      expect(json["countriesUri"], isNull);
      expect(json["states"], isNull);
    });
  });
}
