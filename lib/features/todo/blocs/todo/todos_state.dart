import 'package:equatable/equatable.dart';
import 'package:flutter_plate/features/todo/model/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosState extends Equatable {
  const TodosState();
}

class TodoLoading extends TodosState {
  @override
  String toString() => 'TodoLoading';

  @override
  List<Object> get props => [];
}

class TodosLoading extends TodosState {
  @override
  String toString() => 'TodosLoading';

  @override
  List<Object> get props => [];
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded(this.todos);

  @override
  String toString() => 'TodosLoaded { todos: $todos }';

  @override
  List<Object> get props => [todos];
}

class TodoLoaded extends TodosState {
  final Todo todo;
  final bool canEdit;
  final bool canDelete;

  TodoLoaded(this.todo, this.canEdit, this.canDelete);

  @override
  String toString() => 'TodoLoaded { todo: $todo }';

  @override
  List<Object> get props => [todo, canEdit, canDelete];
}

class TodoNotLoaded extends TodosState {
  @override
  String toString() => 'TodoNotLoaded';

  @override
  List<Object> get props => [];
}

class TodosNotLoaded extends TodosState {
  @override
  String toString() => 'TodosNotLoaded';

  @override
  List<Object> get props => [];
}
