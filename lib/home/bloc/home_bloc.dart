import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState.initial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {

  }
}
