import 'package:commerce_flutter_sdk/src/features/domain/entity/sort_options_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SortOptionEntityMapper {
  static SortOptionEntity toEntity(SortOption model) => SortOptionEntity(
        displayName: model.displayName,
        sortType: model.sortType,
      );

  static SortOption toModel(SortOptionEntity entity) => SortOption(
        displayName: entity.displayName,
        sortType: entity.sortType,
      );
}
