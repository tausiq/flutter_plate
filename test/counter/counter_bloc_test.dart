import 'package:flutter_plate/counter/bloc/bloc.dart';
import 'package:test/test.dart';

void main() {
  CounterBloc counterBloc;

  setUp(() {
    counterBloc = CounterBloc();
  });

  test('initial state is correct', () {
    expect(counterBloc.currentState, 0);
  });

  test('Counter value should be incremented', () {

    expectLater(
      counterBloc.state,
      emitsInOrder([0, 1]),
    );
    counterBloc.dispatch(CounterEvent.increment);
  });

  test('Counter value should be decremented', () {

    expectLater(
      counterBloc.state,
      emitsInOrder([0, -1]),
    );

    counterBloc.dispatch(CounterEvent.decrement);
  });
}
