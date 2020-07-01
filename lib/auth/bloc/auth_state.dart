import 'package:equatable/equatable.dart';
import 'package:flutter_plate/user/user.dart';

/// Since we're using Equatable to allow us to compare different instances
/// of AuthenticationState we need to pass any properties to the superclass.
/// Without super([displayName]), we will not be able to properly compare
/// different instances of Authenticated.
///
abstract class AuthState extends Equatable {
  const AuthState();
}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  String toString() => 'Authenticated { user: $user }';

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => [];
}

class Unregistered extends AuthState {
  @override
  String toString() => 'Unregistered';

  @override
  List<Object> get props => [];
}
