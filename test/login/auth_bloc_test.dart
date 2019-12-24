import 'package:flutter_plate/app/model/api/user.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/auth/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
  });

  test('initial state is correct', () {
    expect(authenticationBloc.initialState, Uninitialized());
  });

  test('dispose does not emit new states', () {
    expectLater(
      authenticationBloc.state,
      emitsInOrder([Uninitialized(), emitsDone]),
    );
    authenticationBloc.close();
  });

  group('AppStarted', () {
    test('emits [uninitialized, unauthenticated] for invalid token', () {
      final expectedResponse = [
        Uninitialized(),
        Unauthenticated()
      ];

      when(userRepository.hasToken()).thenAnswer((_) => Future.value(false));

      expectLater(
        authenticationBloc.state,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(AppStarted());
    });
  });

  group('LoggedIn', () {
    test(
        'emits [uninitialized, loading, authenticated] when token is persisted',
            () {
          final expectedResponse = [
            Uninitialized(),
            Authenticated(User()),
          ];

          expectLater(
            authenticationBloc.state,
            emitsInOrder(expectedResponse),
          );

          authenticationBloc.add(LoggedIn(

          ));
        });
  });

  group('LoggedOut', () {
    test(
        'emits [uninitialized, loading, unauthenticated] when token is deleted',
            () {
          final expectedResponse = [
            Uninitialized(),
            Unauthenticated(),
          ];

          expectLater(
            authenticationBloc.state,
            emitsInOrder(expectedResponse),
          );

          authenticationBloc.add(LoggedOut());
        });
  });
}