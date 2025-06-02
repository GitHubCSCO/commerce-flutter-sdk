import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('Country', () {
    test('fromJson() should correctly deserialize JSON data', () {
      // Arrange
      final jsonData = {
        'id': '1',
        'name': 'Test Country',
        'abbreviation': 'TC',
        'states': [
          {'id': '101', 'name': 'State 1'},
          {'id': '102', 'name': 'State 2'}
        ],
        'properties': {'key1': 'value1', 'key2': null}
      };

      // Act
      final country = Country.fromJson(jsonData);

      // Assert
      expect(country.id, '1');
      expect(country.name, 'Test Country');
      expect(country.abbreviation, 'TC');
      expect(country.states, isNotNull);
      expect(country.states!.length, 2);
      expect(country.states![0], isA<StateModel>());
      expect(country.states![0].id, '101');
      expect(country.states![0].name, 'State 1');
      expect(country.states![1], isA<StateModel>());
      expect(country.states![1].id, '102');
      expect(country.states![1].name, 'State 2');
      expect({"key1": "string"}, containsPair("key1", "string"));
      expect({"key2": null}, containsPair("key2", null));
      expect(country.properties, containsPair("key1", "value1"));
      expect(country.properties, containsPair("key2", null));
    });

    test('toJson() should correctly serialize object to JSON', () {
      // Arrange
      final country = Country(
        id: '1',
        name: 'Test Country',
        abbreviation: 'TC',
        states: [
          StateModel(id: '101', name: 'State 1'),
          StateModel(id: '102', name: 'State 2')
        ],
      );

      // Act
      final jsonData = country.toJson();

      // Assert
      expect(jsonData['id'], '1');
      expect(jsonData['name'], 'Test Country');
      expect(jsonData['abbreviation'], 'TC');
      expect(jsonData['states'], isNotNull);
      expect(jsonData['states'], isA<List>());
      expect(jsonData['states'].length, 2);
      expect(jsonData['states'][0], isA<Map>());
      expect(jsonData['states'][0]['id'], '101');
      expect(jsonData['states'][0]['name'], 'State 1');
      expect(jsonData['states'][1], isA<Map>());
      expect(jsonData['states'][1]['id'], '102');
      expect(jsonData['states'][1]['name'], 'State 2');
    });
  });
}
