import 'dart:async';
import 'package:flutter_plate/user/bloc/bloc.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:flutter_plate/user/user.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';


class MockUserRepository extends Mock implements FirebaseUserRepository {}

void main() {
  UserBloc userBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    userBloc = UserBloc(userRepository: userRepository);
  });

  test('initial state is correct', () {
    expect(userBloc.initialState, UserLoading());
  });

  test('dispose does not emit new states', () {
    expectLater(
      userBloc.state,
      emitsInOrder([UserLoading(), emitsDone]),
    );
    userBloc.close();
  });

  group('LoadUsers', () {
    test('emits [UserLoading] for empty user list', () {
      final expectedResponse = [UserLoading()];

      when(userRepository.users())
          .thenAnswer((_) => Stream<List<User>>.empty());

      expectLater(
        userBloc.state,
        emitsInOrder(expectedResponse),
      );

      userBloc.add(LoadUsers());
    });
  });

  group('LoadUsers', () {
    test('emits [UsersLoaded] for non-empty user list', () {
      List<User> users = List();
      users.add(User());
      users.add(User());

      final expectedResponse = [UserLoading(), UsersLoaded(users)];

      when(userRepository.users())
          .thenAnswer((_) => Stream<List<User>>.value(users));

      expectLater(
        userBloc.state,
        emitsInOrder(expectedResponse),
      );

      userBloc.add(LoadUsers());
    });
  });

  group('UpdateUser', () {
    test('emits [UserLoading] after updating a user', () {
      User user = User();

      final expectedResponse = [UserLoading()];

      when(userRepository.updateUser(user)).thenAnswer((_) => null);

      expectLater(
        userBloc.state,
        emitsInOrder(expectedResponse),
      );

      userBloc.add(UpdateUser(user));
    });
  });
}
