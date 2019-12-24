import 'package:equatable/equatable.dart';

import '../user.dart';

abstract class UserState extends Equatable {
  UserState();
}

class UserLoading extends UserState {
  @override
  String toString() {
    return 'UserLoading{}';
  }

  @override
  List<Object> get props => [];
}

class UsersLoaded extends UserState {
  final List<User> items;

  UsersLoaded([this.items = const []]);

  @override
  String toString() {
    return 'UsersLoaded{items: $items}';
  }

  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final User item;

  UserLoaded(this.item);

  @override
  String toString() {
    return 'UserLoaded{item: $item}';
  }

  @override
  List<Object> get props => [item];
}

class NotLoaded extends UserState {
  @override
  String toString() {
    return 'NotLoaded{}';
  }

  @override
  List<Object> get props => [];
}

