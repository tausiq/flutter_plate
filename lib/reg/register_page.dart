import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/reg/register_form.dart';

import 'bloc/bloc.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
