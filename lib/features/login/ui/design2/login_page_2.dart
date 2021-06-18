import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/constants/assets.dart';
import 'package:flutter_plate/features/login/bloc/bloc.dart';
import 'package:flutter_plate/features/user/firebase_user_repository.dart';

import 'login_form_2.dart';

class LoginPage2 extends StatelessWidget {
  final FirebaseUserRepository _userRepository;
  final Function navCallback;

  LoginPage2({Key key, @required FirebaseUserRepository userRepository, this.navCallback})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter:
                new ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage(Assets.bgLogin),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: LoginForm2(
            navCallback: navCallback,
          ),
        ));
  }
}