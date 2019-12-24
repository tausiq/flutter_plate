import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WorkoutsState extends Equatable {
  WorkoutsState();
}

class WorkoutLoading extends WorkoutsState {
  @override
  String toString() => 'WorkoutLoading';

  @override
  List<Object> get props => [];
}

class WorkoutsLoading extends WorkoutsState {
  @override
  String toString() => 'WorkoutsLoading';

  @override
  List<Object> get props => [];
}

class WorkoutsLoaded extends WorkoutsState {
  final List<Workout> items;
  final int minutesDiff;
  final int totalMinutes;
  final DateTime fromDate;
  final DateTime toDate;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;

  WorkoutsLoaded(
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

class WorkoutLoaded extends WorkoutsState {
  final Workout item;
  final bool canEdit;
  final bool canDelete;

  WorkoutLoaded(this.item, this.canEdit, this.canDelete);

  @override
  String toString() => 'WorkoutLoaded { todo: $item }';

  @override
  List<Object> get props => [item, canEdit, canDelete];
}

class WorkoutNotLoaded extends WorkoutsState {
  @override
  String toString() => 'WorkoutNotLoaded';

  @override
  List<Object> get props => [];
}

class WorkoutsNotLoaded extends WorkoutsState {
  @override
  String toString() => 'WorkoutsNotLoaded';

  @override
  List<Object> get props => [];
}

class FormValueChanged extends WorkoutsState {
  final DateTime dateTime;

  FormValueChanged(this.dateTime);

  @override
  String toString() {
    return 'ValueChanged{dateTime: $dateTime}';
  }

  @override
  List<Object> get props => [dateTime];
}
