import 'package:flutter_plate/workout/bloc/bloc.dart';
import 'package:flutter_plate/workout/firebase_workout_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockWorkoutRepository extends Mock implements FirebaseWorkoutsRepository {}

void main() {
  WorkoutAddEditBloc bloc;
  MockWorkoutRepository workoutRepository;

  setUp(() {
    workoutRepository = MockWorkoutRepository();
    bloc = WorkoutAddEditBloc(workoutsRepository: workoutRepository, workoutId: 'a');
  });

  test('initial state is correct', () {
    expect(bloc.initialState, WorkoutLoading());
  });

  test('dispose does not emit new states', () {
    expectLater(
      bloc.state,
      emitsInOrder([WorkoutLoading(), emitsDone]),
    );
    bloc.close();
  });

  group('LoadWorkout', () {
    test('emits [WorkoutLoading] for empty workout', () {
      final expectedResponse = [
        WorkoutLoading(),
      ];

      expectLater(
        bloc.state,
        emitsInOrder(expectedResponse),
      );

      bloc.add(LoadWorkout());
    });
  });
}
