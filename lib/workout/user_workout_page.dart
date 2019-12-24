import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/widgets/empty_view.dart';
import 'package:flutter_plate/widgets/loading_indicator.dart';
import 'package:flutter_plate/workout/firebase_workout_repository.dart';
import 'package:flutter_plate/workout/workout_add_edit_page.dart';
import 'package:intl/intl.dart';

import 'bloc/bloc.dart';

class UserWorkoutPage extends StatefulWidget {
  static const String PATH = '/meals';

  final String userId;

  UserWorkoutPage({Key key, @required this.userId}) : super(key: key);

  static String generatePath(String userId) {
    Map<String, dynamic> param = {
      'userId': userId,
    };
    Uri uri = Uri(path: PATH, queryParameters: param);
    return uri.toString();
  }

  @override
  _UserMealsPageState createState() => _UserMealsPageState();
}

class _UserMealsPageState extends State<UserWorkoutPage> {
  final WorkoutBloc mealsBloc =
  WorkoutBloc(workoutsRepository: FirebaseWorkoutsRepository(), user: null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutBloc>(
      create: (BuildContext context) {
        return mealsBloc..add(LoadWorkoutsByUserId(widget.userId));
      },
      child: BlocBuilder<WorkoutBloc, WorkoutsState>(builder: (context, state) {
        if (state is WorkoutLoading) return LoadingIndicator();
        return _buildBody(state);
      }),
    );
  }

  Widget _buildBody(WorkoutsState state) {
    return Scaffold(
      appBar: AppBar(title: Text('Calories'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        )
      ]),
      // drawer: NavDrawer(widget.user, 0),
      body: SafeArea(child: _buildMeals(state)),
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

  Widget _buildMeals(WorkoutsState state) {
    final items = state is WorkoutsLoaded ? state.items : null;
    if (items == null || items.isEmpty) return EmptyView('No Meals Found');

    return ListView.builder(
      scrollDirection: Axis.vertical,
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
          subtitle:
          Text(DateFormat('MMM dd, yyyy hh:mm a').format(fullDateTime)),
          trailing: Chip(
            label: Text(
              item.minutes.toString(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onTap: () async {
            AppProvider.getRouter(context).navigateTo(
                context, WorkoutAddEditPage.generatePath(true, workoutId: item.id));
          },
        );
      },
    );
  }
}
