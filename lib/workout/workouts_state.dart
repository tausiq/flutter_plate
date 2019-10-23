import 'package:equatable/equatable.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WorkoutsState extends Equatable {
  WorkoutsState([List props = const []]) : super(props);
}

class WorkoutLoading extends WorkoutsState {
  @override
  String toString() => 'WorkoutLoading';
}

class WorkoutsLoading extends WorkoutsState {
  @override
  String toString() => 'WorkoutsLoading';
}

class WorkoutsLoaded extends WorkoutsState {
  final List<Workout> items;

  WorkoutsLoaded([this.items = const []]) : super([items]);

  @override
  String toString() => 'WorkoutsLoaded { todos: $items }';
}

class WorkoutLoaded extends WorkoutsState {
  final Workout item;
  final bool canEdit;
  final bool canDelete;

  WorkoutLoaded(this.item, this.canEdit, this.canDelete) : super([item]);

  @override
  String toString() => 'WorkoutLoaded { todo: $item }';
}

class WorkoutNotLoaded extends WorkoutsState {
  @override
  String toString() => 'WorkoutNotLoaded';
}

class WorkoutsNotLoaded extends WorkoutsState {
  @override
  String toString() => 'WorkoutsNotLoaded';
}

class FormValueChanged extends WorkoutsState {
  final DateTime dateTime;

  FormValueChanged(this.dateTime) : super([dateTime]);

  @override
  String toString() {
    return 'ValueChanged{dateTime: $dateTime}';
  }
}
