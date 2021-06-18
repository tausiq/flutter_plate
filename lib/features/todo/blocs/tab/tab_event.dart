import 'package:equatable/equatable.dart';
import 'package:flutter_plate/features/todo/model/app_tab.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TabEvent extends Equatable {
  TabEvent();
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  UpdateTab(this.tab);

  @override
  String toString() => 'UpdateTab { tab: $tab }';

  @override
  List<Object> get props => [tab];
}
