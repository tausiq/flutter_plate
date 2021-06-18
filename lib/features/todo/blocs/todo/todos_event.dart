import 'package:equatable/equatable.dart';
import 'package:flutter_plate/features/todo/model/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosEvent extends Equatable {
  TodosEvent();
}

class LoadTodos extends TodosEvent {
  @override
  String toString() => 'LoadTodos';

  @override
  List<Object> get props => [];
}

class LoadTodo extends TodosEvent {
  @override
  String toString() => 'LoadTodo';

  @override
  List<Object> get props => [];
}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo);

  @override
  String toString() => 'AddTodo { todo: $todo }';

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodosEvent {
  final Todo updatedTodo;

  UpdateTodo(this.updatedTodo);

  @override
  String toString() => 'UpdateTodo { updatedTodo: $updatedTodo }';

  @override
  List<Object> get props => [updatedTodo];
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  DeleteTodo(this.todo);

  @override
  String toString() => 'DeleteTodo { todo: $todo }';

  @override
  List<Object> get props => [todo];
}

class ClearCompleted extends TodosEvent {
  @override
  String toString() => 'ClearCompleted';

  @override
  List<Object> get props => [];
}

class ToggleAll extends TodosEvent {
  @override
  String toString() => 'ToggleAll';

  @override
  List<Object> get props => [];
}

class TodoUpdated extends TodosEvent {
  final Todo todo;

  TodoUpdated(this.todo);

  @override
  String toString() => 'TodoUpdated';

  @override
  List<Object> get props => [todo];
}

class TodosUpdated extends TodosEvent {
  final List<Todo> todos;

  TodosUpdated(this.todos);

  @override
  String toString() => 'TodosUpdated';

  @override
  List<Object> get props => [todos];
}
