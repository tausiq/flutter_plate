import 'package:flutter_plate/todo/model/models.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class TodosState extends Equatable {
  TodosState([List props = const []]) : super(props);
}

class TodoLoading extends TodosState {
  @override
  String toString() => 'TodoLoading';
}

class TodosLoading extends TodosState {
  @override
  String toString() => 'TodosLoading';
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded([this.todos = const []]) : super([todos]);

  @override
  String toString() => 'TodosLoaded { todos: $todos }';
}

class TodoLoaded extends TodosState {
  final Todo todo;
  final bool canEdit;
  final bool canDelete;

  TodoLoaded(this.todo, this.canEdit, this.canDelete) : super([todo]);

  @override
  String toString() => 'TodoLoaded { todo: $todo }';
}

class TodoNotLoaded extends TodosState {
  @override
  String toString() => 'TodoNotLoaded';
}

class TodosNotLoaded extends TodosState {
  @override
  String toString() => 'TodosNotLoaded';
}
