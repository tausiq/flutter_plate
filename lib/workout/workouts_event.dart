import 'package:equatable/equatable.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WorkoutsEvent extends Equatable {
  WorkoutsEvent([List props = const []]) : super(props);
}

class LoadWorkouts extends WorkoutsEvent {
  @override
  String toString() => 'LoadWorkouts';
}

class LoadWorkout extends WorkoutsEvent {
  @override
  String toString() => 'LoadWorkout';
}

class AddWorkout extends WorkoutsEvent {
  final Workout item;

  AddWorkout(this.item) : super([item]);

  @override
  String toString() {
    return 'AddWorkout{item: $item}';
  }
}

class UpdateWorkout extends WorkoutsEvent {
  final Workout item;

  UpdateWorkout(this.item) : super([item]);

  @override
  String toString() {
    return 'UpdateWorkout{item: $item}';
  }
}

class DeleteWorkout extends WorkoutsEvent {
  final Workout item;

  DeleteWorkout(this.item) : super([item]);

  @override
  String toString() {
    return 'DeleteWorkout{item: $item}';
  }
}

class WorkoutUpdated extends WorkoutsEvent {
  final Workout item;

  WorkoutUpdated(this.item);

  @override
  String toString() {
    return 'WorkoutUpdated{item: $item}';
  }
}

class WorkoutsUpdated extends WorkoutsEvent {
  final List<Workout> items;
  WorkoutsUpdated(this.items);

  @override
  String toString() {
    return 'WorkoutsUpdated{items: $items}';
  }
}

class DateTimeChanged extends WorkoutsEvent {
  final DateTime dateTime;

  DateTimeChanged(this.dateTime);

  @override
  String toString() {
    return 'DateTimeChanged{dateTime: $dateTime}';
  }
}
