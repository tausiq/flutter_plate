import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Since we're using Equatable to allow us to compare different instances
/// of AuthenticationState we need to pass any properties to the superclass.
/// Without super([displayName]), we will not be able to properly compare
/// different instances of Authenticated.
///
@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final String displayName;

  Authenticated(this.displayName) : super([displayName]);

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

class Unregistered extends AuthenticationState {
  @override
  String toString() => 'Unregistered';
}
