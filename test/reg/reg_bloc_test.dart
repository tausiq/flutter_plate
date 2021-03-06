import 'package:flutter_plate/reg/bloc/bloc.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
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
    expect(RegisterState.empty(), bloc.initialState);
  });

  test('dispose does not emit new states', () {
    expectLater(
      bloc.state,
      emitsInOrder([RegisterState.empty(), emitsDone]),
    );
    bloc.close();
  });

}
