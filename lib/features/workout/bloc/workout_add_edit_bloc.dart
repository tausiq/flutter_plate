import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plate/features/user/firebase_user_repository.dart';
import 'package:flutter_plate/features/workout/bloc/bloc.dart';
import 'package:flutter_plate/features/workout/workout_repository.dart';
import 'package:flutter_plate/features/workout/workout_service.dart';

class WorkoutAddEditBloc extends Bloc<WorkoutAddEditEvent, WorkoutAddEditState> {
  final WorkoutRepository _workoutsRepository;
  StreamSubscription _workoutsSubscription;
  String _workoutId;
  WorkoutService _workoutService;

  WorkoutAddEditBloc({@required WorkoutRepository workoutsRepository, String workoutId})
      : assert(workoutsRepository != null),
        _workoutsRepository = workoutsRepository,
        _workoutId = workoutId,
        super(WorkoutLoading());

  @override
  Stream<WorkoutAddEditState> mapEventToState(WorkoutAddEditEvent event) async* {
    if (event is LoadWorkout) {
      if (_workoutId == null || _workoutId.isEmpty)
        yield WorkoutLoading();
      else
        yield* _mapLoadWorkoutToState();
    } else if (event is AddWorkout) {
      yield* _mapAddWorkoutToState(event);
    } else if (event is UpdateWorkout) {
      yield* _mapUpdateWorkoutToState(event);
    } else if (event is DeleteWorkout) {
      yield* _mapDeleteWorkoutToState(event);
    } else if (event is WorkoutUpdated) {
      yield* _mapWorkoutUpdateToState(event);
    } else if (event is DateTimeChanged) {
      yield FormValueChanged(event.dateTime, event.timeOfDay);
    }
  }

  Stream<WorkoutAddEditState> _mapLoadWorkoutToState() async* {
    _workoutService = WorkoutService((await FirebaseUserRepository().getUser()));
    _workoutsSubscription?.cancel();
    _workoutsRepository.getWorkout(_workoutId).then((val) {
      _workoutService.workout = val;
      add(WorkoutUpdated(val));
    });
  }

  Stream<WorkoutAddEditState> _mapAddWorkoutToState(AddWorkout event) async* {
    _workoutsRepository.addNewWorkout(event.item);
  }

  Stream<WorkoutAddEditState> _mapUpdateWorkoutToState(UpdateWorkout event) async* {
    _workoutsRepository.updateWorkout(event.item);
  }

  Stream<WorkoutAddEditState> _mapDeleteWorkoutToState(DeleteWorkout event) async* {
    _workoutsRepository.deleteWorkout(event.item);
  }

  Stream<WorkoutAddEditState> _mapWorkoutUpdateToState(WorkoutUpdated event) async* {
    yield WorkoutLoaded(
        event.item, _workoutService.canEdit(), _workoutService.canDelete());
  }

  @override
  Future<void> close() {
    _workoutsSubscription?.cancel();
    return super.close();
  }
}
