import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/todo/model/models.dart';
import 'package:flutter_plate/todo/todo_service.dart';

import 'package:meta/meta.dart';

import '../../todos_repository.dart';
import 'bloc.dart';

class TodoDetailsBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _todosRepository;
  StreamSubscription _todosSubscription;
  String _todoId;
  TodoService _todoService;

  TodoDetailsBloc({@required TodosRepository todosRepository, @required String todoId})
      : assert(todosRepository != null), assert(todoId != null),
        _todosRepository = todosRepository, _todoId = todoId;

  @override
  TodosState get initialState => TodoLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodo) {
      yield* _mapLoadTodoToState();
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdateToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodoToState() async* {
    _todoService = TodoService((await UserRepository().getUser()).roles);
    _todosSubscription?.cancel();
    _todosRepository.getTodo(_todoId).then((val) {
        dispatch(TodoUpdated(val));
    });
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _todosRepository.updateTodo(event.updatedTodo);
    yield TodoLoaded(event.updatedTodo, _todoService.canEdit(), _todoService.canDelete());
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _todosRepository.deleteTodo(event.todo);
  }

  Stream<TodosState> _mapTodoUpdateToState(TodoUpdated event) async* {
    yield TodoLoaded(event.todo, _todoService.canEdit(), _todoService.canDelete());
  }

  @override
  void dispose() {
    _todosSubscription?.cancel();
    super.dispose();
  }
}
