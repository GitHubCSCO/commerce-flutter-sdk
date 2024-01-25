// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LegacyConfigurationEntity extends Equatable {
  final List<ConfigSectionEntity>? sections;
  final bool? hasDefaults;
  final bool? isKit;

  const LegacyConfigurationEntity({
    this.sections,
    this.hasDefaults,
    this.isKit,
  });

  LegacyConfigurationEntity copyWith({
    List<ConfigSectionEntity>? sections,
    bool? hasDefaults,
    bool? isKit,
  }) {
    return LegacyConfigurationEntity(
      sections: sections ?? this.sections,
      hasDefaults: hasDefaults ?? this.hasDefaults,
      isKit: isKit ?? this.isKit,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ConfigSectionEntity extends Equatable {
  final String? sectionName;
  final List<ConfigSectionOptionEntity>? options;
  final String? id;
  final int? sortOrder;

  const ConfigSectionEntity({
    this.sectionName,
    this.options,
    this.id,
    this.sortOrder,
  });

  ConfigSectionEntity copyWith({
    String? sectionName,
    List<ConfigSectionOptionEntity>? options,
    String? id,
    int? sortOrder,
  }) {
    return ConfigSectionEntity(
      sectionName: sectionName ?? this.sectionName,
      options: options ?? this.options,
      id: id ?? this.id,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ConfigSectionOptionEntity extends Equatable {
  final String? sectionOptionId;
  final String? sectionName;
  final String? productName;
  final String? productId;
  final String? description;
  final num? price;
  final bool? userProductPrice;
  final bool? selected;
  final int? sortOrder;
  final String? id;
  final String? name;
  final num? quantity;

  const ConfigSectionOptionEntity({
    this.sectionOptionId,
    this.sectionName,
    this.productName,
    this.productId,
    this.description,
    this.price,
    this.userProductPrice,
    this.selected,
    this.sortOrder,
    this.id,
    this.name,
    this.quantity,
  });

  ConfigSectionOptionEntity copyWith({
    String? sectionOptionId,
    String? sectionName,
    String? productName,
    String? productId,
    String? description,
    num? price,
    bool? userProductPrice,
    bool? selected,
    int? sortOrder,
    String? id,
    String? name,
    num? quantity,
  }) {
    return ConfigSectionOptionEntity(
      sectionOptionId: sectionOptionId ?? this.sectionOptionId,
      sectionName: sectionName ?? this.sectionName,
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      price: price ?? this.price,
      userProductPrice: userProductPrice ?? this.userProductPrice,
      selected: selected ?? this.selected,
      sortOrder: sortOrder ?? this.sortOrder,
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
