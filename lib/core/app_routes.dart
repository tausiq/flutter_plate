import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/app/ui/page/app_detail_page.dart';
import 'package:flutter_plate/app/ui/page/app_store_page.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/counter/counter_page.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/auth/auth_page.dart';
import 'package:flutter_plate/timer/bloc/bloc.dart';
import 'package:flutter_plate/timer/ticker.dart';
import 'package:flutter_plate/timer/timer_page.dart';
import 'package:flutter_plate/todo/blocs/todo/todos_bloc.dart';
import 'package:flutter_plate/todo/blocs/todo/todos_event.dart';
import 'package:flutter_plate/todo/firebase_todos_repository.dart';
import 'package:flutter_plate/todo/model/todo.dart';
import 'package:flutter_plate/todo/todo_addedit_page.dart';
import 'package:flutter_plate/todo/todo_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage(name: params['name'][0],);
});

var authRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AuthPage(
    userRepository: AppProvider.getApplication(context).userRepository,
  );
});

var appStoreRouteHander = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AppStorePage();
});

var counterRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CounterPage();
});

var todoRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BlocProvider<TodosBloc>(
    builder: (context) {
      return TodosBloc(
        todosRepository: FirebaseTodosRepository(),
      )..dispatch(LoadTodos());
    },
    child: TodoPage(),
  );
});

var todoAddEditRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      final todosBloc = BlocProvider.of<TodosBloc>(context);
      return TodoAddEditPage(
        onSave: (task, note) {
          todosBloc.dispatch(
            AddTodo(Todo(task, note: note)),
          );
        },
        isEditing: params['isEditing']?.first == 'true',
      );
    });

var timerRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return BlocProvider<TimerBloc>(
        builder: (context) => TimerBloc(ticker: Ticker()),
        child: TimerPage(),
      );
    });

var appDetailRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String appId = params['appId']?.first;
  String heroTag = params['heroTag']?.first;
  String title = params['title']?.first;
  String url = params['url']?.first;
  String titleTag = params['titleTag']?.first;

  return AppDetailPage(
      appId: num.parse(appId),
      heroTag: heroTag,
      title: title,
      url: url,
      titleTag: titleTag);
});

class AppRoutes {
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUND !!!');
    });
    router.define(AuthPage.PATH, handler: authRouteHandler);
    router.define(HomePage.PATH, handler: rootHandler);
    router.define(AppStorePage.PATH, handler: appStoreRouteHander);
    router.define(AppDetailPage.PATH, handler: appDetailRouteHandler);
    router.define(CounterPage.PATH,
        handler: counterRouteHandler, transitionType: TransitionType.fadeIn);
    router.define(TimerPage.PATH,
        handler: timerRouteHandler,
        transitionType: TransitionType.inFromBottom);
    router.define(TodoPage.PATH, handler: todoRouteHandler);
    router.define(TodoAddEditPage.PATH, handler: todoAddEditRouteHandler);
  }
}
