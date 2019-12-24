import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StatsState extends Equatable {
  StatsState();
}

class StatsLoading extends StatsState {
  @override
  String toString() => 'StatsLoading';

  @override
  List<Object> get props => [];
}

class StatsLoaded extends StatsState {
  final int numActive;
  final int numCompleted;

  StatsLoaded(this.numActive, this.numCompleted);

  @override
  String toString() {
    return 'StatsLoaded { numActive: $numActive, numCompleted: $numCompleted }';
  }

  @override
  List<Object> get props => [numActive, numCompleted];
}
