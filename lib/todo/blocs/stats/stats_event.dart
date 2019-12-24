import 'package:equatable/equatable.dart';
import 'package:flutter_plate/todo/model/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StatsEvent extends Equatable {
  StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Todo> todos;

  UpdateStats(this.todos);

  @override
  String toString() => 'UpdateStats { todos: $todos }';

  @override
  List<Object> get props => [todos];
}
