import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/todo/blocs/todo/todos_addedit_bloc.dart';
import 'package:flutter_plate/todo/firebase_todos_repository.dart';
import 'package:flutter_plate/todo/todo_addedit_page.dart';

import 'blocs/todo/bloc.dart';

class TodoDetailsPage extends StatelessWidget {
  final String id;

  TodoDetailsPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = TodosAddEditBloc(todosRepository: FirebaseTodosRepository());
    return BlocBuilder<TodosAddEditBloc, TodosState>(
      bloc: todosBloc,
      builder: (context, state) {
        final todo = (state as TodosLoaded)
            .todos
            .firstWhere((todo) => todo.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Todo',
                icon: Icon(Icons.delete),
                onPressed: () {
                  todosBloc.dispatch(DeleteTodo(todo));
                  Navigator.pop(context, todo);
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
                            todosBloc.dispatch(
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TodoAddEditPage(
                      onSave: (task, note) {
                        todosBloc.dispatch(
                          UpdateTodo(
                            todo.copyWith(task: task, note: note),
                          ),
                        );
                      },
                      isEditing: true,
                      todo: todo,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}