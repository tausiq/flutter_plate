import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/user/user.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/settings/settings_page.dart';
import 'package:flutter_plate/user/users_page.dart';
import 'package:flutter_plate/widgets/empty_view.dart';
import 'package:flutter_plate/widgets/loading_indicator.dart';
import 'package:flutter_plate/workout/firebase_workout_repository.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:flutter_plate/workout/workout_add_edit_page.dart';
import 'package:flutter_plate/workout/bloc/workout_bloc.dart';
import 'package:flutter_plate/workout/bloc/workouts_event.dart';
import 'package:flutter_plate/workout/bloc/workouts_state.dart';
import 'package:intl/intl.dart';
import 'package:preferences/preferences.dart';

import 'calendar_actions.dart';
import 'filter_actions.dart';

class WorkoutPage extends StatefulWidget {
  static const String PATH = '/workout';

  final User user;

  WorkoutPage({Key key, @required this.user}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  WorkoutBloc _workoutBloc;
  List<Workout> items;

  @override
  Widget build(BuildContext context) {
    _workoutBloc = new WorkoutBloc(
        workoutsRepository: FirebaseWorkoutsRepository(), user: widget.user)
      ..add(LoadTodayWorkouts());
    return BlocProvider<WorkoutBloc>(
      create: (BuildContext context) {
        return _workoutBloc;
      },
      child: BlocBuilder<WorkoutBloc, WorkoutListState>(builder: (context, state) {
        if (state is WorkoutListLoading) return LoadingIndicator();
        return _buildBody(state);
      }),
    );
  }

  Widget _buildBody(WorkoutListState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
        actions: getActions(_workoutBloc, widget.user),
      ),
      // drawer: NavDrawer(widget.user, 0),
      body: _buildWorkoutList(state),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppProvider.getRouter(context)
              .navigateTo(context, WorkoutAddEditPage.generatePath(false));
        },
        child: Icon(Icons.add),
        tooltip: 'Add Meal',
      ),
    );
  }

  _buildWorkoutList(WorkoutListState state) {
    DateTime fromDate = DateTime.now(), toDate = DateTime.now();
    TimeOfDay fromTime, toTime;
    int minutes = 0;
    if (state is WorkoutListLoaded) {
      items = state.items;
      fromDate = state.fromDate ?? DateTime.now();
      toDate = state.toDate ?? DateTime.now();
      fromTime = state.fromTime ?? TimeOfDay(hour: 0, minute: 0);
      toTime = state.toTime ?? TimeOfDay(hour: 23, minute: 59);
      fromDate = DateTime(fromDate.year, fromDate.month, fromDate.day,
          fromTime.hour, fromTime.minute);
      toDate = DateTime(
          toDate.year, toDate.month, toDate.day, toTime.hour, toTime.minute);
      minutes = state.totalMinutes;
    }

    if (items == null || items.isEmpty) return EmptyView('No Meals Found');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "From Date: ${DateFormat('MMM dd, yyyy').format(fromDate)}       To Date: ${DateFormat('MMM dd, yyyy').format(toDate)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
                Text(
                  "From Time: ${DateFormat('hh:mm a').format(fromDate)}            To Time: ${DateFormat('hh:mm a').format(toDate)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
                Text(
                  'Total Mins: $minutes        Allowed Mins: ${PrefService.getString('minutes_per_day')}/day',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                )
              ],
            ),
            decoration:
                BoxDecoration(color: Theme.of(context).primaryColorDark)),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items != null ? items.length : 0,
            itemBuilder: (context, index) {
              final item = items[index];
              DateTime fullDateTime = DateTime(
                  item.dateTime.year,
                  item.dateTime.month,
                  item.dateTime.day,
                  item.timeOfDay.hour,
                  item.timeOfDay.minute);
              return ListTile(
                title: Text(item.title),
                subtitle: Text(
                    DateFormat('MMM dd, yyyy hh:mm a').format(fullDateTime)),
                trailing: Chip(
                  label: Text(
                    item.minutes.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: (state is WorkoutListLoaded)
                      ? state.minutesDiff <= 0
                          ? Theme.of(context).primaryColor
                          : Colors.red
                      : Theme.of(context).primaryColor,
                ),
                onTap: () async {
                  AppProvider.getRouter(context).navigateTo(context,
                      WorkoutAddEditPage.generatePath(true, workoutId: item.id));
                },
              );
            },
          ),
        ),
      ],
    );
  }

  getActions(WorkoutBloc bloc, User user) {
    final ret = <Widget>[];
    ret.add(IconButton(
      icon: Icon(Icons.filter_none),
      tooltip: 'See all workouts',
      onPressed: () async {
        _workoutBloc.add(LoadAllWorkouts());
      },
    ));
    ret.add(IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        AppProvider.getRouter(context)
            .navigateTo(context, SettingsPage.PATH)
            .then((val) {
          bloc.add(LoadAllWorkouts());
        });
      },
    ));

    ret.add(IconButton(
      icon: Icon(Icons.calendar_today),
      tooltip: 'Select a day',
      onPressed: () async {
        await showDialog<Null>(
            context: context,
            builder: (BuildContext context) => CalendarActions(bloc));
      },
    ));

    if (user.isManager() || user.isAdmin()) {
      ret.add(IconButton(
        icon: Icon(Icons.group),
        onPressed: () {
          AppProvider.getRouter(context).navigateTo(context, UsersPage.PATH);
        },
      ));
    }

    ret.add(IconButton(
      icon: Icon(Icons.filter_list),
      tooltip: 'Select a range of time',
      onPressed: () async {
        await showDialog<Null>(
            context: context,
            builder: (BuildContext context) => FilterActions(_workoutBloc));
      },
    ));

    return ret;
  }

  @override
  void dispose() {
    _workoutBloc.close();
    super.dispose();
  }
}
