import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/auth/bloc/bloc.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';

class CreateAccountButton extends StatelessWidget {
  //ignore: unused_field
  final FirebaseUserRepository _userRepository;

  CreateAccountButton({Key key, @required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context)..add(CreateAccount());
//        Navigator.of(context).push(
//          MaterialPageRoute(builder: (context) {
//            return RegisterPage(userRepository: _userRepository);
//          }),
//        );
      },
    );
  }
}
