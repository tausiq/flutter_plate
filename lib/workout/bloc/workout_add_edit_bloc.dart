import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/workout/workout_repository.dart';
import 'package:flutter_plate/workout/workout_service.dart';
import 'package:flutter_plate/workout/bloc/workouts_event.dart';
import 'package:flutter_plate/workout/bloc/workouts_state.dart';



class WorkoutsAddEditBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final WorkoutRepository _workoutsRepository;
  StreamSubscription _workoutsSubscription;
  String _workoutId;
  WorkoutService _workoutService;

  WorkoutsAddEditBloc({@required WorkoutRepository workoutsRepository, String workoutId})
      : assert(workoutsRepository != null),
        _workoutsRepository = workoutsRepository,
        _workoutId = workoutId;

  @override
  WorkoutsState get initialState => WorkoutLoading();

  @override
  Stream<WorkoutsState> mapEventToState(WorkoutsEvent event) async* {
    if (event is LoadWorkout) {
      if (_workoutId == null || _workoutId.isEmpty)
        yield WorkoutLoading();
      else
        yield* _mapLoadTodoToState();
    } else if (event is AddWorkout) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateWorkout) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteWorkout) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is WorkoutUpdated) {
      yield* _mapTodoUpdateToState(event);
    } else if (event is DateTimeChanged) {
      yield FormValueChanged(event.dateTime, event.timeOfDay);
    }
  }

  Stream<WorkoutsState> _mapLoadTodoToState() async* {
    _workoutService = WorkoutService((await UserRepository().getUser()));
    _workoutsSubscription?.cancel();
    _workoutsRepository.getWorkout(_workoutId).then((val) {
      _workoutService.workout = val;
      add(WorkoutUpdated(val));
    });
  }

  Stream<WorkoutsState> _mapAddTodoToState(AddWorkout event) async* {
    _workoutsRepository.addNewWorkout(event.item);
  }

  Stream<WorkoutsState> _mapUpdateTodoToState(UpdateWorkout event) async* {
    _workoutsRepository.updateWorkout(event.item);
  }

  Stream<WorkoutsState> _mapDeleteTodoToState(DeleteWorkout event) async* {
    _workoutsRepository.deleteWorkout(event.item);
  }

  Stream<WorkoutsState> _mapTodoUpdateToState(WorkoutUpdated event) async* {
    yield WorkoutLoaded(
        event.item, _workoutService.canEdit(), _workoutService.canDelete());
  }

  @override
  Future<void> close() {
    _workoutsSubscription?.cancel();
    return super.close();
  }
}
