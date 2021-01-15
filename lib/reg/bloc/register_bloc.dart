import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:flutter_plate/util/log/app_log.dart';
import 'package:flutter_plate/util/validation.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseUserRepository _userRepository;

  RegisterBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.empty());

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
          event.email, event.firstName, event.lastName, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validation.isEmailValid(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validation.isPasswordValid(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String firstName,
    String lastName,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      UserCredential result = await _userRepository.signUp(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
      );
      Log.d(result.toString());
      yield RegisterState.success();
    } catch (e) {
      Log.e(e.toString());
      yield RegisterState.failure();
    }
  }
}
