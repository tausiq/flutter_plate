import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_plate/workout/workout.dart';

abstract class WorkoutRepository {
  Future<void> addNewWorkout(Workout item);
  Future<void> deleteWorkout(Workout item);
  Stream<List<Workout>> workouts();
  Stream<List<Workout>> workoutsByUserId(String userId);
  Future<void> updateWorkout(Workout todo);
  Future<Workout> getWorkout(String id);
  Stream<List<Workout>> filteredWorkouts(
      DateTime fromDate, DateTime toDate, TimeOfDay fromTime, TimeOfDay toTime);
}
