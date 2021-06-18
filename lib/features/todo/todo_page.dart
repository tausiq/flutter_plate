import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/features/todo/todo_list_page.dart';

import 'blocs/blocs.dart';

class TodoPage extends StatelessWidget {
  static const String PATH = "/todo";

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final todosBloc = BlocProvider.of<TodosBloc>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(),
        ),
        BlocProvider<FilteredTodosBloc>(
          create: (context) => FilteredTodosBloc(todosBloc: todosBloc),
        ),
        BlocProvider<StatsBloc>(
          create: (context) => StatsBloc(todosBloc: todosBloc),
        ),
      ],
      child: TodoListPage(),
    );
  }
}
