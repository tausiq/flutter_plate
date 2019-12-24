import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'firebase_user_repository.dart';
import 'user.dart';

class UserAddEditPage extends StatefulWidget {
  static const String PATH = '/addedituser';

  final bool isEditing;
  final String userId;

  UserAddEditPage({Key key, @required this.isEditing, this.userId})
      : super(key: key);

  static String generatePath(bool isEditing, {String userId}) {
    Map<String, dynamic> param = {
      'isEditing': isEditing.toString(),
      'userId': userId,
    };
    Uri uri = Uri(path: PATH, queryParameters: param);
    return uri.toString();
  }

  @override
  _UserAddEditPageState createState() => _UserAddEditPageState();
}

class _UserAddEditPageState extends State<UserAddEditPage> {
  static final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;
  String _email;
  String _password;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isEditing => widget.isEditing;

  UserAddEditBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    _bloc = UserAddEditBloc(
        userRepository: FirebaseUserRepository(), mealId: widget.userId)
      ..add(LoadUser());

    return BlocBuilder<UserAddEditBloc, UserState>(
        bloc: _bloc,
        builder: (context, state) {
          final item = state is UserLoaded ? state.item : null;
          if (state is UserLoaded) {
            _firstNameController.text = isEditing ? item?.firstName : '';
            _lastNameController.text = isEditing ? item?.lastName : '';
            _emailController.text = isEditing ? item?.email : '';
            _passwordController.text = '******';
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isEditing ? 'Edit User' : 'Add User',
              ),
              actions: isEditing
                  ? [
                IconButton(
                  tooltip: 'Delete User',
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _bloc.add(DeleteUser(item));
                    Navigator.pop(context, item);
                  },
                )
              ]
                  : [],
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _userFormKey,
                child: ListView(
                  children: [
                    TextFormField(
                      autofocus: !isEditing,
                      style: textTheme.headline,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Please enter first name'
                            : null;
                      },
                      onSaved: (value) => _firstName = value,
                      controller: _firstNameController,
                    ),
                    TextFormField(
                      autofocus: !isEditing,
                      style: textTheme.headline,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Please enter last name'
                            : null;
                      },
                      onSaved: (value) => _lastName = value,
                      controller: _lastNameController,
                    ),
                    TextFormField(
                      autofocus: !isEditing,
                      style: textTheme.headline,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty ? 'Please enter email' : null;
                      },
                      onSaved: (value) => _email = value,
                      controller: _emailController,
                    ),
                    TextFormField(
                      autofocus: !isEditing,
                      enabled: !isEditing,
                      style: textTheme.headline,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Please enter password'
                            : null;
                      },
                      onSaved: (value) => _password = value,
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: isEditing ? 'Save changes' : 'Add User',
              child: Icon(Icons.check),
              onPressed: () {
                if (_userFormKey.currentState.validate()) {
                  _userFormKey.currentState.save();

                  if (widget.isEditing) {
                    _bloc.add(
                      UpdateUser(
                        item.copyWith(
                          firstName: _firstName,
                          lastName: _lastName,
                          email: _email,
                        ),
                      ),
                    );
                  } else {
                    _bloc.add(
                      AddUser(
                          User(
                              firstName: _firstName,
                              lastName: _lastName,
                              email: _email),
                          _password),
                    );
                  }
                  Navigator.pop(context);
                }
              },
            ),
          );
        });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
