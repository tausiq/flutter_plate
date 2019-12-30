import 'package:equatable/equatable.dart';
import 'package:flutter_plate/todo/model/models.dart';
import 'package:flutter_plate/todo/model/visibility_filter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FilteredTodosEvent extends Equatable {
  FilteredTodosEvent();
}

class UpdateFilter extends FilteredTodosEvent {
  final VisibilityFilter filter;

  UpdateFilter(this.filter);

  @override
  String toString() => 'UpdateFilter { filter: $filter }';

  @override
  List<Object> get props => [filter];
}

class UpdateTodos extends FilteredTodosEvent {
  final List<Todo> todos;

  UpdateTodos(this.todos);

  @override
  String toString() => 'UpdateTodos { todos: $todos }';

  @override
  List<Object> get props => [todos];
}
