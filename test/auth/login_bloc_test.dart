import 'package:flutter_plate/auth/bloc/bloc.dart';
import 'package:flutter_plate/login/bloc/bloc.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements FirebaseUserRepository {}

class MockAuthenticationBloc extends Mock implements AuthBloc {}

void main() {
  LoginBloc loginBloc;
  MockUserRepository userRepository;
  MockAuthenticationBloc authenticationBloc;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(userRepository: userRepository);
  });

  tearDown(() {
    loginBloc.close();
    authenticationBloc.close();
  });

  test('initial state is correct', () {
    expect(LoginState.empty(), loginBloc.initialState);
  });

  test('dispose does not emit new states', () {
    expectLater(
      loginBloc.state,
      emitsInOrder([LoginState.empty(), emitsDone]),
    );
    loginBloc.close();
  });

  group('EmailChanged', () {
    test('email changed', () {
      expectLater(loginBloc.state, LoginState.empty());
      loginBloc..add(EmailChanged(email: 'hello@gmail.com'));
    });
  });

  group('PasswordChanged', () {
    test('password changed', () {
      expectLater(loginBloc.state, LoginState.empty());
      loginBloc..add(PasswordChanged(password: 'hello'));
    });
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        LoginState.empty(),
        LoginState.loading(),
        LoginState.success(),
        emitsDone
      ];

      when(userRepository.authenticate(
        username: 'valid.username',
        password: 'valid.password',
      )).thenAnswer((_) => Future.value('token'));

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      );

      loginBloc.add(LoginWithCredentialsPressed(
        username: 'valid.email',
        password: 'valid.password',
      ));
    });
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        LoginState.empty(),
        LoginState.loading(),
        LoginState.success(),
      ];

      when(userRepository.authenticate(
        username: 'valid.username',
        password: 'valid.password',
      )).thenAnswer((_) => Future.value('token'));

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authenticationBloc.add(LoggedIn())).called(1);
      });

      loginBloc.add(LoginWithCredentialsPressed(
        username: 'valid.email',
        password: 'valid.password',
      ));
    });
  });
}
