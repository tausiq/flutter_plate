import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../firebase_user_repository.dart';
import 'bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseUserRepository _userRepository;
  StreamSubscription _usersSubscription;

  UserBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  UserState get initialState => UserListLoading();


  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUsers) {
      yield* _mapLoadUsersToState();
    } else if (event is UsersUpdated) {
      yield* _mapMealsUpdateToState(event);
    }
  }

  Stream<UserState> _mapLoadUsersToState() async* {
    _usersSubscription?.cancel();
    _usersSubscription = _userRepository.users().listen(
          (items) {
        add(
          UsersUpdated(items),
        );
      },
    );
  }

  Stream<UserState> _mapMealsUpdateToState(UsersUpdated event) async* {
    yield UserListLoaded(event.items);
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}

