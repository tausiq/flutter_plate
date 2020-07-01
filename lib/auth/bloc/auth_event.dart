import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  @override
  String toString() => 'LoggedIn';

  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => [];
}

class CreateAccount extends AuthEvent {
  @override
  String toString() => 'CreateAccount';

  @override
  List<Object> get props => [];
}
