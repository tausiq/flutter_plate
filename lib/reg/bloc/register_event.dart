import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class FirstNameChanged extends RegisterEvent {
  final String name;

  FirstNameChanged({@required this.name}) : super([name]);

  @override
  String toString() => 'FirstNameChanged { name :$name }';
}

class LastNameChanged extends RegisterEvent {
  final String name;

  LastNameChanged({@required this.name}) : super([name]);

  @override
  String toString() => 'LastNameChanged { name :$name }';
}


class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  Submitted({@required this.firstName, @required this.lastName, @required this.email, @required this.password})
      : super([firstName, lastName, email, password]);

  @override
  String toString() {
    return 'Submitted{firstName: $firstName, lastName: $lastName, email: $email, password: $password}';
  }


}
