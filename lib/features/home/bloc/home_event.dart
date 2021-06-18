import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class DrawerItemSelected extends HomeEvent {
  final int index;
  final String title;
  DrawerItemSelected(this.index, this.title);

  @override
  List<Object> get props => [index, title];
}
