import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/login/ui/design1/splash_page.dart';
import 'package:flutter_plate/login/ui/design2/landing_page_2.dart';
import 'package:flutter_plate/reg/ui/design1/register_page.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:preferences/preferences.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/bloc.dart';

/// AuthPage is not a page as such, it only decides which page to show initially
class AuthPage extends StatelessWidget {
  static const String PATH = '/';
  final FirebaseUserRepository userRepository;

  AuthPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      cubit: BlocProvider.of<AuthBloc>(context),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, AuthState state) {
    if (state is Uninitialized) {
      return SplashPage();
    }
    if (state is Authenticated) {
      AppProvider.getApplication(context).setLoggedInUser(state.user);
      PrefService.setString('user_id', state.user.id);
      return HomePage(
        user: state.user,
      );
    }
    if (state is Unauthenticated) {
      return LandingPage2();
//      return LoginPage(userRepository: userRepository);
    }
    if (state is Unregistered) {
      return RegisterPage(userRepository: userRepository);
    }
    return null;
  }
}
