import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

import 'package:test/test.dart';

void main() {
  final queryParams = ProductsQueryParameters(query: 's');

  group(
      'Product query parameters',
      () => {
            test('Inheriting default values', () {
              expect(16, queryParams.pageSize);
              expect(1, queryParams.page);
            })
          });
}
