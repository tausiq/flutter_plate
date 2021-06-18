import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/features/reg/ui/design1/register_form.dart';
import 'package:flutter_plate/features/user/firebase_user_repository.dart';

import '../../bloc/bloc.dart';

class RegisterPage extends StatelessWidget {
  final FirebaseUserRepository _userRepository;

  RegisterPage({Key key, @required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
