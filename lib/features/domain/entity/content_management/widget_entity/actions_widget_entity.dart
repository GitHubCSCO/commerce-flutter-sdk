import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_layout_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:equatable/equatable.dart';

class Action extends Equatable {
  final ActionType? type;
  final String? icon;
  final String? text;
  final String? url;
  final bool? requiresAuth;

  const Action({
    this.type,
    this.icon,
    this.text,
    this.url,
    this.requiresAuth,
  });

  Action copyWith({
    ActionType? type,
    String? icon,
    String? text,
    String? url,
    bool? requiresAuth,
  }) {
    return Action(
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
  final List<Action>? actions;
  final List<Action>? childWidgets;

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
    List<Action>? actions,
    List<Action>? childWidgets,
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
