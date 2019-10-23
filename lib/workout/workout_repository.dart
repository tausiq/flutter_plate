import 'dart:async';

import 'package:flutter_plate/workout/workout.dart';

abstract class WorkoutRepository {
  Future<void> addNewWorkout(Workout item);
  Future<void> deleteWorkout(Workout item);
  Stream<List<Workout>> workouts();
  Future<void> updateWorkout(Workout todo);
  Future<Workout> getWorkout(String id);
}
