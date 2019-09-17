import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_plate/todo/model/models.dart';

import 'package:meta/meta.dart';

import '../../todos_repository.dart';
import 'bloc.dart';

class TodosAddEditBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _todosRepository;
  StreamSubscription _todosSubscription;
  String _todoId;

  TodosAddEditBloc({@required TodosRepository todosRepository, String todoId})
      : assert(todosRepository != null),
        _todosRepository = todosRepository, _todoId = todoId;

  @override
  TodosState get initialState => TodoLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodo) {
      if (_todoId == null) yield TodoLoading();
      else yield* _mapLoadTodoToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdateToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodoToState() async* {
    _todosSubscription?.cancel();
    _todosRepository.getTodo(_todoId).then((val) {
      dispatch(TodoUpdated(val));
    });
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    _todosRepository.addNewTodo(event.todo);
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _todosRepository.updateTodo(event.updatedTodo);
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _todosRepository.deleteTodo(event.todo);
  }

  Stream<TodosState> _mapTodoUpdateToState(TodoUpdated event) async* {
    yield TodoLoaded(event.todo);
  }

  @override
  void dispose() {
    _todosSubscription?.cancel();
    super.dispose();
  }
}
