import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/auth/bloc/bloc.dart';
import 'package:flutter_plate/login/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';



class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  LoginBloc loginBloc;
  MockUserRepository userRepository;
  MockAuthenticationBloc authenticationBloc;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(
      userRepository: userRepository
    );
  });

  test('initial state is correct', () {
    expect(LoginState.empty(), loginBloc.initialState);
  });

  test('dispose does not emit new states', () {
    expectLater(
      loginBloc.state,
      emitsInOrder([LoginState.empty(), emitsDone]),
    );
    loginBloc.dispose();
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        LoginState.empty(),
        LoginState.loading(),
        LoginState.empty(),
      ];

      when(userRepository.authenticate(
        username: 'valid.username',
        password: 'valid.password',
      )).thenAnswer((_) => Future.value('token'));

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authenticationBloc.dispatch(LoggedIn())).called(1);
      });

      loginBloc.dispatch(LoginWithCredentialsPressed(
        email: 'valid.email',
        password: 'valid.password',
      ));
    });
  });
}