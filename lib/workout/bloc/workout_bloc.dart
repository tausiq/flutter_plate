import 'dart:async';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/user/user.dart';
import 'package:flutter_plate/workout/bloc/workouts_event.dart';
import 'package:flutter_plate/workout/bloc/workouts_state.dart';
import 'package:flutter_plate/workout/workout_repository.dart';
import 'package:meta/meta.dart';
import 'package:preferences/preference_service.dart';

class WorkoutBloc extends Bloc<WorkoutsEvent, WorkoutListState> {
  final WorkoutRepository _workoutsRepository;
  StreamSubscription _workoutsSubscription;
  User _user;

  WorkoutBloc({@required WorkoutRepository workoutsRepository, @required User user})
      : assert(workoutsRepository != null),
        _workoutsRepository = workoutsRepository, _user = user;

  @override
  WorkoutListState get initialState => WorkoutListLoading();

  @override
  Stream<WorkoutListState> mapEventToState(WorkoutsEvent event) async* {
    if (event is LoadAllWorkouts) {
      yield* _mapLoadWorkoutsToState();
    } else if (event is LoadWorkoutsByUserId) {
      yield* _mapLoadWorkoutsByUserIdToState(event);
    } else if (event is WorkoutsUpdated) {
      yield* _mapWorkoutsUpdateToState(event);
    } else if (event is LoadFilteredWorkouts) {
      yield* _mapLoadFilteredWorkoutsToState(event);
    }
  }

  Stream<WorkoutListState> _mapLoadWorkoutsByUserIdToState(
      LoadWorkoutsByUserId event) async* {
    _workoutsSubscription?.cancel();
    _workoutsSubscription = _workoutsRepository.workoutsByUserId(event.userId).listen(
          (workouts) {
        add(
          WorkoutsUpdated(workouts),
        );
      },
    );
  }

  Stream<WorkoutListState> _mapLoadWorkoutsToState() async* {
    _workoutsSubscription?.cancel();
    _workoutsSubscription =
        _workoutsRepository.workoutsByUserId(PrefService.getString('user_id')).listen(
              (workouts) {
            add(
              WorkoutsUpdated(workouts),
            );
          },
        );
  }

  Stream<WorkoutListState> _mapLoadFilteredWorkoutsToState(
      LoadFilteredWorkouts event) async* {
    _workoutsSubscription?.cancel();
    _workoutsSubscription = _workoutsRepository
        .filteredWorkouts(
        event.fromDate, event.toDate, event.fromTime, event.toTime)
        .listen(
          (workouts) {
        add(WorkoutsUpdated(workouts,
            fromDate: event.fromDate,
            toDate: event.toDate,
            fromTime: event.fromTime,
            toTime: event.toTime));
      },
    );
  }

  Stream<WorkoutListState> _mapWorkoutsUpdateToState(WorkoutsUpdated event) async* {
    int totalCalories = 0;
    DateTime fromDate;
    DateTime toDate;
    TimeOfDay fromTime = TimeOfDay(hour: 0, minute: 0);
    TimeOfDay toTime = TimeOfDay(hour: 23, minute: 59);

    int minYear = DateTime.now().year;
    int maxYear = DateTime.now().year;

    event.items.forEach((item) {
      totalCalories += item.minutes;
      minYear = math.min(item.dateTime.year, minYear);
      maxYear = math.max(item.dateTime.year, maxYear);
    });

    if (event.fromDate == null) {
      fromDate = DateTime(minYear);
      toDate = DateTime(maxYear, 12, 31, 23, 59);
    } else {
      fromDate = DateTime(event.fromDate.year, event.fromDate.month, event.fromDate.day, event.fromTime.hour, event.fromTime.minute);
      toDate = DateTime(event.toDate.year, event.toDate.month, event.toDate.day, event.toTime.hour, event.toTime.minute);
      fromTime = event.fromTime;
      toTime = event.toTime;
    }

    int diff =(_user == null) ? 0 : totalCalories - int.tryParse(PrefService.getString('minutes_per_day_${_user.id}'));
    if (toDate.year != fromDate.year || toDate.month != fromDate.month || toDate.day != fromDate.day) diff = 0;

    yield WorkoutListLoaded(event.items, diff, totalCalories, fromDate,
        toDate, fromTime, toTime);
  }

  @override
  Future<void> close() {
    _workoutsSubscription?.cancel();
    return super.close();
  }
}
