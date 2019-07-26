import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/login/splash_page.dart';
import 'package:flutter_plate/login/user_repo.dart';

import 'auth_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'home_page.dart';
import 'loading_indicator.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  final UserRepository userRepository;

  AuthPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          } else return null;
        },
      ),
    );
  }
}