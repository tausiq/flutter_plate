import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/todo/firebase_todos_repository.dart';
import 'package:flutter_plate/todo/todo_addedit_page.dart';
import 'package:flutter_plate/util/log/Log.dart';

import 'blocs/todo/bloc.dart';
import 'blocs/todo/todo_details_bloc.dart';
import 'model/todo.dart';

class TodoDetailsPage extends StatelessWidget {
  final String id;

  TodoDetailsPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoBloc =
        TodoDetailsBloc(todosRepository: FirebaseTodosRepository(), todoId: id)..dispatch(LoadTodo());
    return BlocBuilder<TodoDetailsBloc, TodosState>(
      bloc: todoBloc,
      builder: (context, state) {
        final todo = state is TodoLoaded ? state.todo : null;
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Todo',
                icon: Icon(Icons.delete),
                onPressed: () {
                  if ((state as TodoLoaded).canDelete) {
                    todoBloc.dispatch(DeleteTodo(todo));
                    Navigator.pop(context, todo);
                  } else {
                    Log.w("no permission for delete");
                  }
                },
              )
            ],
          ),
          body: todo == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Checkbox(
                                value: todo.complete,
                                onChanged: (_) {
                                  todoBloc.dispatch(
                                    UpdateTodo(
                                      todo.copyWith(complete: !todo.complete),
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${todo.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      todo.task,
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                  ),
                                ),
                                Text(
                                  todo.note,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Edit Todo',
            child: Icon(Icons.edit),
            onPressed: todo == null
                ? null
                : () {
              AppProvider.getRouter(context)
                  .navigateTo(context, TodoAddEditPage.generatePath(true, todoId: todo.id));
                  },
          ),
        );
      },
    );
  }
}
