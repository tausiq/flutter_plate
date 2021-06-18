import 'package:equatable/equatable.dart';

import '../app_user.dart';

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

class UsersUpdated extends UserEvent {
  final List<AppUser> items;

  UsersUpdated(this.items);

  @override
  String toString() {
    return 'UsersUpdated{items: $items}';
  }

  @override
  List<Object> get props => [];
}
