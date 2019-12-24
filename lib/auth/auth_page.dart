import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/login/login_page.dart';
import 'package:flutter_plate/login/splash_page.dart';
import 'package:flutter_plate/reg/register_page.dart';
import 'package:flutter_plate/user/user_repo.dart';
import 'package:preferences/preferences.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/bloc.dart';

class AuthPage extends StatelessWidget {
  static const String PATH = '/';
  final UserRepository userRepository;

  AuthPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (BuildContext context, AuthenticationState state) {
        if (state is Uninitialized) {
          return SplashPage();
        }
        if (state is Authenticated) {
          AppProvider.getApplication(context).loggedInUser = state.user;
          PrefService.setString('user_id', state.user.id);
          return HomePage(user: state.user,);

        }
        if (state is Unauthenticated) {
          return LoginPage(userRepository: userRepository);
        }
        if (state is Unregistered) {
          return RegisterPage(userRepository: userRepository);
        }
          return null;
      },
    );
  }
}
