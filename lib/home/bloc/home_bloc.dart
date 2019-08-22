import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/counter/counter_page.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/timer/timer_page.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState.initial();

  BuildContext _context;

  void setContext(BuildContext context) {
    this._context = context;
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: Add Logic
  }

  void openHomePage() async {
    AppProvider.getRouter(_context).pop(_context);
    AppProvider.getRouter(_context).navigateTo(_context, HomePage.PATH);
  }

  void openCounterPage() async {
    AppProvider.getRouter(_context).pop(_context);
    AppProvider.getRouter(_context).navigateTo(_context, CounterPage.PATH);
  }

    void openTimerPage() async {
    AppProvider.getRouter(_context).pop(_context);
    AppProvider.getRouter(_context).navigateTo(_context, TimerPage.PATH);
  }
}
