import 'dart:async';

import 'package:flutter_plate/user/bloc/bloc.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';


class MockUserRepository extends Mock implements FirebaseUserRepository {}

void main() {
  UserAddEditBloc userBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    userBloc = UserAddEditBloc(userRepository: userRepository, userId: 'a');
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

//  group('LoadUser', () {
//    test('emits [UserLoading] for empty user list', () {
//      final expectedResponse = [
//        UserLoading(),
//        UserLoaded(User()),
//      ];
//
//      when(userRepository.getUserById('a'))
//          .thenAnswer((_) => Future.value(User()));
//
//      expectLater(
//        userBloc.state,
//        emitsInOrder(expectedResponse),
//      );
//
//      userBloc.dispatch(LoadUser());
//    });
//  });
}
