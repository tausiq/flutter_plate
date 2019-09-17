import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/auth/bloc/bloc.dart';

import 'bloc/bloc.dart';
import 'nav_drawer.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/home';

  final String name;

  HomePage({Key key, @required this.name}) : super(key: key);

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
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  authenticationBloc.dispatch(LoggedOut());
                },
              )
            ],
          ),
          drawer: NavDrawer(null, 0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(child: Text('Welcome ${widget.name}!')),
            ],
          ),
        ));
  }
}
