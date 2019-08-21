import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/login/auth_page_factory.dart';
import 'package:flutter_plate/login/splash_page.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';

import 'auth_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'home_page.dart';
import 'loading_indicator.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  static const String PATH = '/';
  final UserRepository userRepository;

  AuthPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..dispatch(AppStarted());
      },
      child: AuthPageFactory(
        userRepository: userRepository,
      ),
    );
  }
}
