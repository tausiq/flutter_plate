import 'package:flutter/material.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/reg/register_page.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
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
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterPage(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
