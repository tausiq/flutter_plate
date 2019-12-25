import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../workout.dart';

@immutable
abstract class WorkoutAddEditState extends Equatable {
  WorkoutAddEditState();

}

class WorkoutLoading extends WorkoutAddEditState {

  @override
  String toString() {
    return 'WorkoutLoading{}';
  }

  @override
  List<Object> get props => [];
}

class WorkoutLoaded extends WorkoutAddEditState {
  final Workout item;
  final bool canEdit;
  final bool canDelete;

  WorkoutLoaded(this.item, this.canEdit, this.canDelete);

  @override
  String toString() => 'WorkoutLoaded { todo: $item }';

  @override
  List<Object> get props => [item, canEdit, canDelete];
}

class FormValueChanged extends WorkoutAddEditState {
  final DateTime dateTime;
  final TimeOfDay timeOfDay;

  FormValueChanged(this.dateTime, this.timeOfDay);

  @override
  String toString() {
    return 'FormValueChanged{dateTime: $dateTime timeOfDay: $timeOfDay}';
  }

  @override
  List<Object> get props => [dateTime, timeOfDay];
}

class WorkoutNotLoaded extends WorkoutAddEditState {
  @override
  String toString() => 'WorkoutNotLoaded';

  @override
  List<Object> get props => [];
}
