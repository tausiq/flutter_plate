import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/login/auth_bloc.dart';
import 'package:flutter_plate/login/auth_event.dart';

import 'bloc/bloc.dart';
import 'nav_drawer.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = new HomeBloc();

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider<HomeBloc>(
        builder: (BuildContext context) {
          _homeBloc.setContext(context);
          return _homeBloc;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          drawer: NavDrawer(null, 0),
          body: Container(
            child: Center(
                child: RaisedButton(
              child: Text('logout'),
              onPressed: () {
                authenticationBloc.dispatch(LoggedOut());
              },
            )),
          ),
        ));
  }
}
