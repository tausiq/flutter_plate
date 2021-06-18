import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_plate/features/workout/workout.dart';

abstract class WorkoutRepository {
  Future<void> addNewWorkout(Workout item);
  Future<void> deleteWorkout(Workout item);
  Stream<List<Workout>> todayWorkout(String userId);
  Stream<List<Workout>> workouts(String userId);
  Stream<List<Workout>> workoutsByUserId(String userId);
  Future<void> updateWorkout(Workout todo);
  Future<Workout> getWorkout(String id);
  Stream<List<Workout>> filteredWorkouts(
      DateTime fromDate, DateTime toDate, TimeOfDay fromTime, TimeOfDay toTime);
}
