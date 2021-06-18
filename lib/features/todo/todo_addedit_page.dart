import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/features/todo/blocs/blocs.dart';
import 'package:flutter_plate/features/todo/blocs/todo/todos_addedit_bloc.dart';

import 'firebase_todos_repository.dart';
import 'model/todo.dart';

typedef OnSaveCallback = Function(String task, String note);

class TodoAddEditPage extends StatefulWidget {
  static const String PATH = '/addedittodo';

  final bool isEditing;
  final String todoId;

  TodoAddEditPage({
    Key key,
    @required this.isEditing,
    this.todoId,
  }) : super(key: key);

  static String generatePath(bool isEditing, {String todoId}) {
    Map<String, dynamic> parma = {
      'isEditing': isEditing.toString(),
      'todoId': todoId,
    };
    Uri uri = Uri(path: PATH, queryParameters: parma);
    return uri.toString();
  }

  @override
  _TodoAddEditPageState createState() => _TodoAddEditPageState();
}

class _TodoAddEditPageState extends State<TodoAddEditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  TodosAddEditBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    _bloc = TodosAddEditBloc(
        todosRepository: FirebaseTodosRepository(), todoId: widget.todoId)
      ..add(LoadTodo());

    return BlocBuilder<TodosAddEditBloc, TodosState>(
        bloc: _bloc,
        builder: (context, state) {
          final todo = state is TodoLoaded ? state.todo : null;
          _taskController.text = isEditing ? todo?.task : '';
          _noteController.text = isEditing ? todo?.note : '';
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isEditing ? 'Edit Todo' : 'Add Todo',
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
//                      initialValue: isEditing ? todo?.task : '',
                      autofocus: !isEditing,
                      style: textTheme.headline5,
                      decoration: InputDecoration(
                        hintText: 'What needs to be done?',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty ? 'Please enter some text' : null;
                      },
                      onSaved: (value) => _task = value,
                      controller: _taskController,
                    ),
                    TextFormField(
//                      initialValue: isEditing ? todo?.note : '',
                      maxLines: 10,
                      style: textTheme.subtitle1,
                      decoration: InputDecoration(
                        hintText: 'Additional Notes...',
                      ),
                      onSaved: (value) => _note = value,
                      controller: _noteController,
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: isEditing ? 'Save changes' : 'Add Todo',
              child: Icon(isEditing ? Icons.check : Icons.add),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  if (widget.isEditing) {
                    _bloc
                      ..add(
                        UpdateTodo(
                          todo.copyWith(task: _task, note: _note),
                        ),
                      );
                  } else {
                    _bloc.add(
                      AddTodo(Todo(_task, note: _note)),
                    );
                  }

//                  widget.onSave(_task, _note);
                  Navigator.pop(context);
                }
              },
            ),
          );
        });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
