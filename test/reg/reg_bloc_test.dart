import 'package:flutter_plate/features/reg/bloc/bloc.dart';
import 'package:flutter_plate/features/user/firebase_user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockUserRepository extends Mock implements FirebaseUserRepository {}

void main() {
  MockUserRepository userRepository;
  RegisterBloc bloc;

  setUp(() {
    userRepository = MockUserRepository();
    bloc = RegisterBloc(userRepository: userRepository);
  });

  test('initial state is correct', () {
    expect(RegisterState.empty(), bloc.state);
  });

  test('dispose does not emit new states', () {
    expectLater(
      bloc.state,
      emitsInOrder([RegisterState.empty(), emitsDone]),
    );
    bloc.close();
  });
}
