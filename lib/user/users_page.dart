import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/user/app_user.dart';
import 'package:flutter_plate/widgets/empty_view.dart';
import 'package:flutter_plate/widgets/loading_indicator.dart';
import 'package:flutter_plate/workout/user_workout_page.dart';

import 'bloc/bloc.dart';
import 'firebase_user_repository.dart';
import 'user_add_edit_page.dart';

class UsersPage extends StatefulWidget {
  static const String PATH = '/users';

  final AppUser user;

  UsersPage({Key key, @required this.user}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final UserBloc bloc = UserBloc(userRepository: FirebaseUserRepository());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (BuildContext context) {
        return bloc..add(LoadUsers());
      },
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserListLoading) return LoadingIndicator();
        return _buildBody(state);
      }),
    );
  }

  Widget _buildBody(UserState state) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: SafeArea(child: _buildUsers(state)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppProvider.getRouter(context)
              .navigateTo(context, UserAddEditPage.generatePath(false));
        },
        child: Icon(Icons.add),
        tooltip: 'Add Meal',
      ),
    );
  }

  _buildUsers(UserState state) {
    final items = state is UserListLoaded ? state.items : null;
    if (items == null || items.isEmpty) return EmptyView('No users found');
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items != null ? items.length : 0,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.firstName + ' ' + item.lastName),
          subtitle: Text(item.email),
          trailing: _getRoleChip(item),
          onTap: () async {
            if (widget.user.isManager()) {
              AppProvider.getRouter(context).navigateTo(
                  context, UserAddEditPage.generatePath(true, userId: item.id));
            } else if (widget.user.isAdmin()) {
              AppProvider.getRouter(context)
                  .navigateTo(context, UserWorkoutPage.generatePath(item.id));
            }
          },
        );
      },
    );
  }

  _getRoleChip(AppUser item) {
    MaterialColor color;
    String role;
    if (item.roles.containsKey('admin') && item.roles['admin']) {
      color = Colors.red;
      role = 'Admin';
    } else if (item.roles.containsKey('manager') && item.roles['manager']) {
      color = Colors.green;
      role = 'Manager';
    } else {
      color = Colors.blue;
      role = 'User';
    }

    return Chip(
      label: Text(
        role,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
  }
}
