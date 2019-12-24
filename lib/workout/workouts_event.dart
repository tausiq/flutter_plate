import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WorkoutsEvent extends Equatable {
  WorkoutsEvent();
}

class LoadWorkouts extends WorkoutsEvent {
  @override
  String toString() => 'LoadWorkouts';

  @override
  List<Object> get props => [];
}

class LoadWorkoutsByUserId extends WorkoutsEvent {
  final String userId;

  LoadWorkoutsByUserId(this.userId);

  @override
  String toString() {
    return 'LoadWorkoutsByUserId{userId: $userId}';
  }

  @override
  List<Object> get props => [userId];
}

class LoadFilteredWorkouts extends WorkoutsEvent {
  final DateTime fromDate;
  final DateTime toDate;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;

  LoadFilteredWorkouts(this.fromDate, this.toDate, this.fromTime, this.toTime);

  @override
  String toString() {
    return 'LoadFilteredWorkouts { fromDate: $fromDate, toDate: $toDate, fromTime: $fromTime, toTime: $toTime }';
  }

  @override
  List<Object> get props => [fromDate, toDate, fromTime, toTime];
}

class LoadWorkout extends WorkoutsEvent {
  @override
  String toString() => 'LoadWorkout';

  @override
  List<Object> get props => [];
}

class AddWorkout extends WorkoutsEvent {
  final Workout item;

  AddWorkout(this.item);

  @override
  String toString() {
    return 'AddWorkout{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class UpdateWorkout extends WorkoutsEvent {
  final Workout item;

  UpdateWorkout(this.item);

  @override
  String toString() {
    return 'UpdateWorkout{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class DeleteWorkout extends WorkoutsEvent {
  final Workout item;

  DeleteWorkout(this.item);

  @override
  String toString() {
    return 'DeleteWorkout{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class WorkoutUpdated extends WorkoutsEvent {
  final Workout item;

  WorkoutUpdated(this.item);

  @override
  String toString() {
    return 'WorkoutUpdated{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class WorkoutsUpdated extends WorkoutsEvent {
  final List<Workout> items;
  final DateTime fromDate;
  final DateTime toDate;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;

  WorkoutsUpdated(this.items,
      {this.fromDate, this.toDate, this.fromTime, this.toTime});

  @override
  String toString() {
    return 'WorkoutsUpdated{items: $items}';
  }

  @override
  List<Object> get props => [items, fromDate, toDate, fromTime, toTime];
}

class DateTimeChanged extends WorkoutsEvent {
  final DateTime dateTime;

  DateTimeChanged(this.dateTime);

  @override
  String toString() {
    return 'DateTimeChanged{dateTime: $dateTime}';
  }

  @override
  List<Object> get props => [dateTime];
}
