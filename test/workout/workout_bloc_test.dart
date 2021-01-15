import 'package:flutter_plate/user/app_user.dart';
import 'package:flutter_plate/workout/bloc/bloc.dart';
import 'package:flutter_plate/workout/workout_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockWorkoutRepository extends Mock implements WorkoutRepository {}

void main() {
  WorkoutBloc workoutsBloc;
  MockWorkoutRepository workoutRepository;

  setUp(() {
    workoutRepository = MockWorkoutRepository();
    workoutsBloc = WorkoutBloc(workoutsRepository: workoutRepository, user: AppUser());
  });

  test('initial state is correct', () {
    expect(workoutsBloc.state, WorkoutListLoading());
  });

  test('dispose does not emit new states', () {
    expectLater(
      workoutsBloc.state,
      emitsInOrder([WorkoutListLoading(), emitsDone]),
    );
    workoutsBloc.close();
  });
}
