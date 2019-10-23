import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/app/model/api/user.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/settings/settings_page.dart';
import 'package:flutter_plate/workout/workout_add_edit_page.dart';
import 'package:flutter_plate/workout/workout_bloc.dart';

class WorkoutPage extends StatefulWidget {
  static const String PATH = '/home';

  final User user;

  WorkoutPage({Key key, @required this.user}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final WorkoutBloc _workoutBloc = new WorkoutBloc();

  @override
  Widget build(BuildContext context) {

    return BlocProvider<WorkoutBloc>(
        builder: (BuildContext context) {
          return _workoutBloc;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Calories'),
            actions: getActions(widget.user),
          ),
          // drawer: NavDrawer(widget.user, 0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                  child: Text(
                      'Welcome ${widget.user.firstName} ${widget.user.lastName}!')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppProvider.getRouter(context)
                  .navigateTo(context, WorkoutAddEditPage.generatePath(false));
            },
            child: Icon(Icons.add),
            tooltip: 'Add Meal',
          ),
        ));
  }

  getActions(User user) {
    final ret = <Widget>[];
    ret.add(IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        AppProvider.getRouter(context).navigateTo(context, SettingsPage.PATH);
      },
    ));

    ret.add(IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {},
    ));

    if (user.isManager() || user.isAdmin()) {
      ret.add(IconButton(
        icon: Icon(Icons.group),
        onPressed: () {},
      ));
    }

    return ret;
  }
}
