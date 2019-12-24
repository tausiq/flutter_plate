import 'package:equatable/equatable.dart';

import '../user.dart';

abstract class UserEvent extends Equatable {
  UserEvent();
}

class LoadUsers extends UserEvent {
  @override
  String toString() {
    return 'LoadUsers{}';
  }

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  @override
  String toString() {
    return 'LoadUser{}';
  }

  @override
  List<Object> get props => [];
}

class AddUser extends UserEvent {
  final User user;
  final String password;

  AddUser(this.user, this.password);

  @override
  String toString() {
    return 'AddUser{user: $user, password: $password}';
  }

  @override
  List<Object> get props => [user];
}

class UpdateUser extends UserEvent {
  final User item;

  UpdateUser(this.item);

  @override
  String toString() {
    return 'UpdateUser{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class DeleteUser extends UserEvent {
  final User item;

  DeleteUser(this.item);

  @override
  String toString() {
    return 'DeleteUser{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class UserUpdated extends UserEvent {
  final User item;

  UserUpdated(this.item);

  @override
  String toString() {
    return 'UserUpdated{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class UsersUpdated extends UserEvent {
  final List<User> items;

  UsersUpdated(this.items);

  @override
  String toString() {
    return 'UsersUpdated{items: $items}';
  }

  @override
  List<Object> get props => [];
}

