import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/features/app/ui/app_detail_page.dart';
import 'package:flutter_plate/features/app/ui/app_store_page.dart';
import 'package:flutter_plate/features/auth/auth_page.dart';
import 'package:flutter_plate/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_plate/features/auth/bloc/bloc.dart';
import 'package:flutter_plate/features/counter/counter_page.dart';
import 'package:flutter_plate/features/help/help_page.dart';
import 'package:flutter_plate/features/home/home_page.dart';
import 'package:flutter_plate/features/post/ui/post_page.dart';
import 'package:flutter_plate/features/settings/settings_page.dart';
import 'package:flutter_plate/features/social/social_page.dart';
import 'package:flutter_plate/features/timer/bloc/bloc.dart';
import 'package:flutter_plate/features/timer/ticker.dart';
import 'package:flutter_plate/features/timer/timer_page.dart';
import 'package:flutter_plate/features/todo/blocs/todo/todos_bloc.dart';
import 'package:flutter_plate/features/todo/blocs/todo/todos_event.dart';
import 'package:flutter_plate/features/todo/firebase_todos_repository.dart';
import 'package:flutter_plate/features/todo/todo_addedit_page.dart';
import 'package:flutter_plate/features/todo/todo_page.dart';
import 'package:flutter_plate/features/user/user_add_edit_page.dart';
import 'package:flutter_plate/features/user/users_page.dart';
import 'package:flutter_plate/features/workout/user_workout_page.dart';
import 'package:flutter_plate/features/workout/workout_add_edit_page.dart';
import 'package:flutter_plate/features/workout/workout_page.dart';

var rootHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage(
    user: AppProvider.getApplication(context).loggedInUser,
  );
});

var authRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var userRepository = AppProvider.getApplication(context).userRepository;
  return BlocProvider<AuthBloc>(
    create: (context) {
      return AuthBloc(userRepository: userRepository)..add(AppStarted());
    },
    child: AuthPage(
      userRepository: userRepository,
    ),
  );
});

var appStoreRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AppStorePage();
});

var settingsRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SettingsPage();
});

var usersRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UsersPage(user: AppProvider.getApplication(context).loggedInUser);
});

var workoutRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WorkoutPage(user: AppProvider.getApplication(context).loggedInUser);
});

var userWorkoutRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserWorkoutPage(userId: params['userId']?.first);
});

var workoutAddEditRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WorkoutAddEditPage(
    isEditing: params['isEditing']?.first == 'true',
    workoutId: params['workoutId']?.first,
    userId: params['userId']?.first,
  );
});

var userAddEditRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserAddEditPage(
    isEditing: params['isEditing']?.first == 'true',
    userId: params['userId']?.first,
  );
});

var counterRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CounterPage();
});

var todoRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BlocProvider<TodosBloc>(
    create: (context) {
      return TodosBloc(
        todosRepository: FirebaseTodosRepository(),
      )..add(LoadTodos());
    },
    child: TodoPage(),
  );
});

var helpRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HelpPage();
});

var postRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PostPage();
});

var socialRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SocialPage();
});

var todoAddEditRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TodoAddEditPage(
    isEditing: params['isEditing']?.first == 'true',
    todoId: params['todoId']?.first,
  );
});

var timerRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BlocProvider<TimerBloc>(
    create: (context) => TimerBloc(ticker: Ticker()),
    child: TimerPage(),
  );
});

var appDetailRouteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
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
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler =
        Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUND !!!');
      return;
    });
    router.define(AuthPage.PATH, handler: authRouteHandler);
    router.define(HomePage.PATH, handler: rootHandler);
    router.define(AppStorePage.PATH, handler: appStoreRouteHandler);
    router.define(AppDetailPage.PATH, handler: appDetailRouteHandler);
    router.define(CounterPage.PATH,
        handler: counterRouteHandler, transitionType: TransitionType.fadeIn);
    router.define(TimerPage.PATH,
        handler: timerRouteHandler, transitionType: TransitionType.inFromBottom);
    router.define(TodoPage.PATH, handler: todoRouteHandler);
    router.define(TodoAddEditPage.PATH, handler: todoAddEditRouteHandler);
    router.define(SettingsPage.PATH, handler: settingsRouteHandler);
    router.define(WorkoutPage.PATH, handler: workoutRouteHandler);
    router.define(WorkoutAddEditPage.PATH, handler: workoutAddEditRouteHandler);
    router.define(UsersPage.PATH, handler: usersRouteHandler);
    router.define(UserWorkoutPage.PATH, handler: userWorkoutRouteHandler);
    router.define(UserAddEditPage.PATH, handler: userAddEditRouteHandler);
    router.define(HelpPage.PATH, handler: helpRouteHandler);
    router.define(PostPage.PATH, handler: postRouteHandler);
    router.define(SocialPage.PATH, handler: socialRouteHandler);
  }
}
