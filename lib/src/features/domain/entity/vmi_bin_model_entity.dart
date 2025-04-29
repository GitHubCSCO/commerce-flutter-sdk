import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/vmi_bin_model_entity_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VmiBinModelEntity extends Equatable {
  final String id;
  final String vmiLocationId;
  final String binNumber;
  final String? productId;
  final double? minimumQty;
  final double? maximumQty;
  final DateTime? lastCountDate;
  final double? lastCountQty;
  final String? lastCountUserName;
  final DateTime? previousCountDate;
  final double? previousCountQty;
  final String? previousCountUserName;
  final DateTime? lastOrderDate;
  ProductEntity? productEntity;

  VmiBinModelEntity({
    required this.id,
    required this.vmiLocationId,
    this.binNumber = '',
    this.productId,
    this.minimumQty,
    this.maximumQty,
    this.lastCountDate,
    this.lastCountQty,
    this.lastCountUserName,
    this.previousCountDate,
    this.previousCountQty,
    this.previousCountUserName,
    this.lastOrderDate,
    this.productEntity,
  });

  @override
  List<Object?> get props => [id];

  factory VmiBinModelEntity.fromJson(Map<String, dynamic> json) =>
      VmiBinModelEntityMapper.toEntity(VmiBinModel.fromJson(json));

  Map<String, dynamic> toJson() =>
      VmiBinModelEntityMapper.toModel(this).toJson();
}
