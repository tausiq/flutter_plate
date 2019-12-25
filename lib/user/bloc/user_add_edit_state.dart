import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../user.dart';

@immutable
abstract class UserAddEditState extends Equatable {
  UserAddEditState();
}

class UserLoading extends UserAddEditState {
  @override
  String toString() {
    return 'UserLoading{}';
  }

  @override
  List<Object> get props => [];
}

class UserLoaded extends UserAddEditState {
  final User item;

  UserLoaded(this.item);

  @override
  String toString() {
    return 'UserLoaded{item: $item}';
  }

  @override
  // TODO: implement props
  List<Object> get props => [item];
}
