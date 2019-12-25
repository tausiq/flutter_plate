import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../user.dart';

@immutable
abstract class UserAddEditEvent extends Equatable {
  UserAddEditEvent();
}

class LoadUser extends UserAddEditEvent {
  @override
  String toString() {
    return 'LoadUser{}';
  }

  @override
  List<Object> get props => [];
}

class AddUser extends UserAddEditEvent {
  final User user;
  final String password;

  AddUser(this.user, this.password);

  @override
  String toString() {
    return 'AddUser{user: $user, password: $password}';
  }

  @override
  List<Object> get props => [user, password];
}

class UpdateUser extends UserAddEditEvent {
  final User item;

  UpdateUser(this.item);

  @override
  String toString() {
    return 'UpdateUser{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class DeleteUser extends UserAddEditEvent {
  final User item;

  DeleteUser(this.item);

  @override
  String toString() {
    return 'DeleteUser{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class UserUpdated extends UserAddEditEvent {
  final User item;

  UserUpdated(this.item);

  @override
  String toString() {
    return 'UserUpdated{item: $item}';
  }

  @override
  List<Object> get props => [item];
}
