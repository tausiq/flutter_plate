import 'package:equatable/equatable.dart';
import 'package:flutter_plate/user/user.dart';
import 'package:meta/meta.dart';

/// Since we're using Equatable to allow us to compare different instances
/// of AuthenticationState we need to pass any properties to the superclass.
/// Without super([displayName]), we will not be able to properly compare
/// different instances of Authenticated.
///
@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final User user;

  const Authenticated(this.user);

  @override
  String toString() => 'Authenticated { user: $user }';

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => [];
}

class Unregistered extends AuthenticationState {
  @override
  String toString() => 'Unregistered';

  @override
  List<Object> get props => [];
}
