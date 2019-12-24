import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/login/splash_page.dart';
import 'package:flutter_plate/user/user_repo.dart';
import 'package:preferences/preferences.dart';

import 'bloc/auth_bloc.dart';
import '../login/login_page.dart';
import 'bloc/bloc.dart';

class AuthPageFactory extends StatelessWidget {
  final UserRepository userRepository;

  AuthPageFactory({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

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
        } else
          return null;
      },
    );
  }
}
