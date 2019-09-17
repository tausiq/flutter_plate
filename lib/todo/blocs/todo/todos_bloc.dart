import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_plate/todo/model/models.dart';

import 'package:meta/meta.dart';

import '../../todos_repository.dart';
import 'bloc.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _todosRepository;
  StreamSubscription _todosSubscription;

  TodosBloc({@required TodosRepository todosRepository})
      : assert(todosRepository != null),
        _todosRepository = todosRepository;

  @override
  TodosState get initialState => TodosLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    _todosSubscription?.cancel();
    _todosSubscription = _todosRepository.todos().listen(
          (todos) {
        dispatch(
          TodosUpdated(todos),
        );
      },
    );
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    final state = currentState;
    if (state is TodosLoaded) {
      final allComplete = state.todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = state.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      updatedTodos.forEach((updatedTodo) {
        _todosRepository.updateTodo(updatedTodo);
      });
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    final state = currentState;
    if (state is TodosLoaded) {
      final List<Todo> completedTodos =
      state.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {
        _todosRepository.deleteTodo(completedTodo);
      });
    }
  }

  Stream<TodosState> _mapTodosUpdateToState(TodosUpdated event) async* {
    yield TodosLoaded(event.todos);
  }

  @override
  void dispose() {
    _todosSubscription?.cancel();
    super.dispose();
  }
}
