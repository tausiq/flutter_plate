import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/todo/todos_bloc.dart';
import 'model/todo.dart';

typedef OnSaveCallback = Function(String task, String note);

class TodoAddEditPage extends StatefulWidget {
  static const String PATH = '/addedittodo';

  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  TodoAddEditPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.todo,
  }) : super(key: key);

  static String generatePath(
      bool isEditing) {
    Map<String, dynamic> parma = {
      'isEditing': isEditing.toString(),
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                initialValue: isEditing ? widget.todo.task : '',
                autofocus: !isEditing,
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _note = value,
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
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}