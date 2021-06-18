import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent();
}

class FirstNameChanged extends RegisterEvent {
  final String name;

  FirstNameChanged({@required this.name});

  @override
  String toString() => 'FirstNameChanged { name :$name }';

  @override
  List<Object> get props => [name];
}

class LastNameChanged extends RegisterEvent {
  final String name;

  LastNameChanged({@required this.name});

  @override
  String toString() => 'LastNameChanged { name :$name }';

  @override
  List<Object> get props => [name];
}


class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email});

  @override
  String toString() => 'EmailChanged { email :$email }';

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  String toString() => 'PasswordChanged { password: $password }';

  @override
  List<Object> get props => [password];
}

class Submitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  Submitted({@required this.firstName, @required this.lastName, @required this.email, @required this.password});

  @override
  String toString() {
    return 'Submitted{firstName: $firstName, lastName: $lastName, email: $email, password: $password}';
  }

  @override
  List<Object> get props => [firstName, lastName, email, password];
}
