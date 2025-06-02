import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('StateModel', () {
    test('fromJson() should correctly deserialize JSON data', () {
      // Arrange
      final jsonData = {
        'id': '1',
        'name': 'Test State',
        'abbreviation': 'TS',
        'states': [
          {'id': '101', 'name': 'Sub State 1'},
          {'id': '102', 'name': 'Sub State 2'}
        ],
        'properties': {'key1': 'value1', 'key2': null}
      };

      // Act
      final stateModel = StateModel.fromJson(jsonData);

      // Assert
      expect(stateModel.id, '1');
      expect(stateModel.name, 'Test State');
      expect(stateModel.abbreviation, 'TS');
      expect(stateModel.states, isNotNull);
      expect(stateModel.states!.length, 2);
      expect(stateModel.states![0], isA<StateModel>());
      expect(stateModel.states![0].id, '101');
      expect(stateModel.states![0].name, 'Sub State 1');
      expect(stateModel.states![1], isA<StateModel>());
      expect(stateModel.states![1].id, '102');
      expect(stateModel.states![1].name, 'Sub State 2');
      expect(stateModel.properties, containsPair("key1", "value1"));
      expect(stateModel.properties, containsPair("key2", null));
    });

    test('toJson() should correctly serialize object to JSON', () {
      // Arrange
      final stateModel = StateModel(
        id: '1',
        name: 'Test State',
        abbreviation: 'TS',
        states: [
          StateModel(id: '101', name: 'Sub State 1'),
          StateModel(id: '102', name: 'Sub State 2')
        ],
      );

      // Act
      final jsonData = stateModel.toJson();

      // Assert
      expect(jsonData['id'], '1');
      expect(jsonData['name'], 'Test State');
      expect(jsonData['abbreviation'], 'TS');
      expect(jsonData['states'], isNotNull);
      expect(jsonData['states'], isA<List>());
      expect(jsonData['states'].length, 2);
      expect(jsonData['states'][0], isA<Map>());
      expect(jsonData['states'][0]['id'], '101');
      expect(jsonData['states'][0]['name'], 'Sub State 1');
      expect(jsonData['states'][1], isA<Map>());
      expect(jsonData['states'][1]['id'], '102');
      expect(jsonData['states'][1]['name'], 'Sub State 2');
    });
  });
}
