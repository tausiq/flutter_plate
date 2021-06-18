import 'package:equatable/equatable.dart';

import '../app_user.dart';

abstract class UserState extends Equatable {
  UserState();
}

class UserListLoading extends UserState {
  @override
  String toString() {
    return 'UserListLoading{}';
  }

  @override
  List<Object> get props => [];
}

class UserListLoaded extends UserState {
  final List<AppUser> items;

  UserListLoaded([this.items = const []]);

  @override
  String toString() {
    return 'UsersLoaded{items: $items}';
  }

  @override
  List<Object> get props => [];
}

class UserListNotLoaded extends UserState {
  @override
  String toString() {
    return 'NotLoaded{}';
  }

  @override
  List<Object> get props => [];
}
