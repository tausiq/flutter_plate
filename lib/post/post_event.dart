import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class PostEvent extends Equatable {}

class Fetch extends PostEvent {
  @override
  String toString() => 'Fetch';
}
