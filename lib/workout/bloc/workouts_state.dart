import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WorkoutListState extends Equatable {
  WorkoutListState();
}

class WorkoutListLoading extends WorkoutListState {
  @override
  String toString() => 'WorkoutLoading';

  @override
  List<Object> get props => [];
}

class WorkoutListLoaded extends WorkoutListState {
  final List<Workout> items;
  final int minutesDiff;
  final int totalMinutes;
  final DateTime fromDate;
  final DateTime toDate;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;

  WorkoutListLoaded(
      [this.items,
        this.minutesDiff,
        this.totalMinutes,
        this.fromDate,
        this.toDate,
        this.fromTime,
        this.toTime]);

  @override
  String toString() => 'WorkoutsLoaded { todos: $items }';

  @override
  List<Object> get props => [items, minutesDiff, totalMinutes, fromDate, toDate, fromTime, toTime];
}

class WorkoutListNotLoaded extends WorkoutListState {
  @override
  String toString() => 'WorkoutsNotLoaded';

  @override
  List<Object> get props => [];
}
