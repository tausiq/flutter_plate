import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../workout.dart';

@immutable
abstract class WorkoutAddEditEvent extends Equatable {
  WorkoutAddEditEvent();
}

class LoadWorkout extends WorkoutAddEditEvent {
  @override
  String toString() => 'LoadWorkout';

  @override
  List<Object> get props => [];
}

class AddWorkout extends WorkoutAddEditEvent {
  final Workout item;

  AddWorkout(this.item);

  @override
  String toString() {
    return 'AddWorkout{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class UpdateWorkout extends WorkoutAddEditEvent {
  final Workout item;

  UpdateWorkout(this.item);

  @override
  String toString() {
    return 'UpdateWorkout{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class DeleteWorkout extends WorkoutAddEditEvent {
  final Workout item;

  DeleteWorkout(this.item);

  @override
  String toString() {
    return 'DeleteWorkout{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class WorkoutUpdated extends WorkoutAddEditEvent {
  final Workout item;
      final DateTime fromDate;
  final DateTime toDate;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;


  WorkoutUpdated(this.item, {this.fromDate, this.toDate, this.fromTime, this.toTime});


  @override
  String toString() {
    return 'WorkoutUpdated{item: $item, fromDate: $fromDate, toDate: $toDate, fromTime: $fromTime, toTime: $toTime}';
  }

  @override
  List<Object> get props => [item, fromDate, toDate, fromTime, toTime];
}

class DateTimeChanged extends WorkoutAddEditEvent {
  final DateTime dateTime;
  final TimeOfDay timeOfDay;

  DateTimeChanged(this.dateTime, this.timeOfDay);

  @override
  String toString() {
    return 'DateTimeChanged{dateTime: $dateTime timeOfDay: $timeOfDay}';
  }

  @override
  List<Object> get props => [dateTime, timeOfDay];
}
