import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super(props);
}

class DrawerItemSelected extends HomeEvent {
  final int index;
  final String title;
  DrawerItemSelected(this.index, this.title);
}
