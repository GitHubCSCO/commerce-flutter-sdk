import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:test/test.dart';

void main() {
  final queryParams = ProductsQueryParameters(search: 's');

  group(
      'Product query parameters',
      () => {
            test('Inheriting default values', () {
              expect(16, queryParams.pageSize);
              expect(1, queryParams.page);
            })
          });
}
