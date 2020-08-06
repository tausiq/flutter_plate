import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:meta/meta.dart';
import 'package:preferences/preferences.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseUserRepository _userRepository;

  AuthBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(Uninitialized());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is CreateAccount) {
      yield Unregistered();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final user = await _userRepository.getUser();
    PrefService.setString('user_id', user.id);
    yield Authenticated(user);
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    PrefService.clear();
    await _userRepository.signOut();
  }
}
