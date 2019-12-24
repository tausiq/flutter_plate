import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../user_repository.dart';
import 'bloc.dart';

class UserAddEditBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription _userSubscription;
  String _userId;

  UserAddEditBloc({@required UserRepository userRepository, String mealId})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _userId = mealId;

  @override
  UserState get initialState => UserLoading();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUser) {
      if (_userId == null || _userId.isEmpty)
        yield UserLoading();
      else
        yield* _mapLoadUserToState();
    } else if (event is AddUser) {
      yield* _mapAddUserToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    } else if (event is DeleteUser) {
      yield* _mapDeleteUserToState(event);
    } else if (event is UserUpdated) {
      yield* _mapUserUpdateToState(event);
    }
  }

  Stream<UserState> _mapLoadUserToState() async* {
    _userSubscription?.cancel();
    _userRepository.getUserById(_userId).then((val) {
      add(UserUpdated(val));
    });
  }

  Stream<UserState> _mapAddUserToState(AddUser event) async* {
    _userRepository.addNewUser(event.user, event.password);
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event) async* {
    _userRepository.updateUser(event.item);
  }

  Stream<UserState> _mapDeleteUserToState(DeleteUser event) async* {
    _userRepository.deleteUser(event.item);
  }

  Stream<UserState> _mapUserUpdateToState(UserUpdated event) async* {
    yield UserLoaded(event.item);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
