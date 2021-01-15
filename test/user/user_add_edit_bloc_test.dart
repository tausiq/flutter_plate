import 'package:flutter_plate/user/app_user.dart';
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
    expect(userBloc.state, UserListLoading());
  });

  test('dispose does not emit new states', () {
    expectLater(
      userBloc.state,
      emitsInOrder([UserListLoading(), emitsDone]),
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

  group('UpdateUser', () {
    test('emits [UserLoading] after updating a user', () {
      AppUser user = AppUser();

      final expectedResponse = [UserListLoading()];

      when(userRepository.updateUser(user)).thenAnswer((_) => null);

      expectLater(
        userBloc.state,
        emitsInOrder(expectedResponse),
      );

      userBloc.add(UpdateUser(user));
    });
  });
}
