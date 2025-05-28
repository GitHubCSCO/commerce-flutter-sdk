import 'package:commerce_flutter_sdk/src/features/domain/converter/cms_converter/action_layout_type_converter.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:equatable/equatable.dart';

class ActionLinkEntity extends Equatable {
  final ActionType? type;
  final String? icon;
  final String? text;
  final String? url;
  final bool? requiresAuth;

  const ActionLinkEntity({
    this.type,
    this.icon,
    this.text,
    this.url,
    this.requiresAuth,
  });

  ActionLinkEntity copyWith({
    ActionType? type,
    String? icon,
    String? text,
    String? url,
    bool? requiresAuth,
  }) {
    return ActionLinkEntity(
      type: type ?? this.type,
      icon: icon ?? this.icon,
      text: text ?? this.text,
      url: url ?? this.url,
      requiresAuth: requiresAuth ?? this.requiresAuth,
    );
  }

  @override
  List<Object?> get props => [type, icon, text, url, requiresAuth];
}

class ActionsWidgetEntity extends WidgetEntity {
  final ActionsLayout? layout;
  final List<ActionLinkEntity>? actions;
  final List<ActionLinkEntity>? childWidgets;

  const ActionsWidgetEntity({
    String? id,
    WidgetType? type,
    String? subType,
    this.layout,
    this.actions,
    this.childWidgets,
  }) : super(id: id, type: type, subType: subType);

  @override
  ActionsWidgetEntity copyWith({
    String? id,
    WidgetType? type,
    String? subType,
    ActionsLayout? layout,
    List<ActionLinkEntity>? actions,
    List<ActionLinkEntity>? childWidgets,
  }) {
    return ActionsWidgetEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      layout: layout ?? this.layout,
      actions: actions ?? this.actions,
      childWidgets: childWidgets ?? this.childWidgets,
    );
  }

  @override
  List<Object?> get props => [id, type, subType, layout, actions, childWidgets];
}
