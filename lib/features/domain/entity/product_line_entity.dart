// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductLineEntity extends Equatable {
  final String? id;
  final String? name;
  final int? count;
  final bool? selected;

  ProductLineEntity({
    this.id,
    this.name,
    this.count,
    this.selected,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ProductLineEntity copyWith({
    String? id,
    String? name,
    int? count,
    bool? selected,
  }) {
    return ProductLineEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
      selected: selected ?? this.selected,
    );
  }
}
