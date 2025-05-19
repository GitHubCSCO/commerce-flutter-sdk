import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

@JsonEnum()
enum CmsType {
  @JsonValue('Classic')
  classic,

  @JsonValue('Spire')
  spire,

  @JsonValue('Headless')
  headless
}
