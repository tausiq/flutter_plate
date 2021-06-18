import 'package:flutter_plate/features/counter/bloc/bloc.dart';
import 'package:test/test.dart';

void main() {
  CounterBloc counterBloc;

  setUp(() {
    counterBloc = CounterBloc();
  });

  tearDown(() {
    counterBloc.close();
  });

  test('initial state is correct', () {
    expect(counterBloc.state, 0);
  });

  test('Counter value should be incremented', () {
    expectLater(
      counterBloc.state,
      emitsInOrder([0, 1]),
    );
    counterBloc.add(CounterEvent.increment);
  });

  test('Counter value should be decremented', () {
    expectLater(
      counterBloc.state,
      emitsInOrder([0, -1]),
    );

    counterBloc.add(CounterEvent.decrement);
  });
}
