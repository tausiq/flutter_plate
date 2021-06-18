import 'package:equatable/equatable.dart';
import 'package:flutter_plate/features/todo/model/models.dart';
import 'package:flutter_plate/features/todo/model/visibility_filter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FilteredTodosState extends Equatable {
  FilteredTodosState();
}

class FilteredTodosLoading extends FilteredTodosState {
  @override
  String toString() => 'FilteredTodosLoading';

  @override
  List<Object> get props => [];
}

class FilteredTodosLoaded extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  FilteredTodosLoaded(this.filteredTodos, this.activeFilter);

  @override
  String toString() {
    return 'FilteredTodosLoaded { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }

  @override
  List<Object> get props => [filteredTodos, activeFilter];
}
