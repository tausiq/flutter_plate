import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/auth/bloc/auth_bloc.dart';
import 'package:flutter_plate/auth/bloc/auth_event.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/counter/counter_page.dart';
import 'package:flutter_plate/help/help_page.dart';
import 'package:flutter_plate/home/bloc/bloc.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/user/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_plate/settings/settings_page.dart';
import 'package:flutter_plate/timer/timer_page.dart';
import 'package:flutter_plate/todo/todo_page.dart';
import 'package:flutter_plate/user/users_page.dart';
import 'package:flutter_plate/workout/workout_page.dart';

class NavDrawer extends StatelessWidget {
  final User user;
  final int selectedIndex;

  NavDrawer(this.user, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    final AuthenticationBloc _authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildHeader(context),
          _getItem(
              0,
              Icons.home,
              AppLocalizations.of(context).tr('drawer.home.title'),
              AppLocalizations.of(context).tr('drawer.home.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, HomePage.PATH);
          }),
          _getItem(
              1,
              Icons.category,
              AppLocalizations.of(context).tr('drawer.app_store.title'),
              AppLocalizations.of(context).tr('drawer.app_store.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
          }),
          _getItem(
              2,
              Icons.fastfood,
              AppLocalizations.of(context).tr('drawer.counter.title'),
              AppLocalizations.of(context).tr('drawer.counter.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context)
                .navigateTo(context, CounterPage.PATH);
          }),
          _getItem(
              3,
              Icons.favorite,
              AppLocalizations.of(context).tr('drawer.post.title'),
              AppLocalizations.of(context).tr('drawer.post.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
          }),
          _getItem(
              4,
              Icons.rate_review,
              AppLocalizations.of(context).tr('drawer.timer.title'),
              AppLocalizations.of(context).tr('drawer.timer.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, TimerPage.PATH);
          }),
          _getItem(
              5,
              Icons.work,
              AppLocalizations.of(context).tr('drawer.todo.title'),
              AppLocalizations.of(context).tr('drawer.todo.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, TodoPage.PATH);
          }),
          _getItem(
              6,
              Icons.airline_seat_recline_extra,
              AppLocalizations.of(context).tr('drawer.workout.title'),
              AppLocalizations.of(context).tr('drawer.workout.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context)
                .navigateTo(context, WorkoutPage.PATH);
          }),
        _getItem(
            7,
            Icons.group,
            AppLocalizations.of(context).tr('drawer.users.title'),
            AppLocalizations.of(context).tr('drawer.users.subtitle'),
                () {
              AppProvider.getRouter(context).pop(context);
              AppProvider.getRouter(context).navigateTo(context, UsersPage.PATH);
            }),

        Divider(),
          _getItem(
              8,
              Icons.settings,
              AppLocalizations.of(context).tr('title_settings'),
              AppLocalizations.of(context).tr('subtitle_settings'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context)
                .navigateTo(context, SettingsPage.PATH);
          }),
          _getItem(
              9,
              Icons.exit_to_app,
              AppLocalizations.of(context).tr('title_logout'),
              AppLocalizations.of(context).tr('subtitle_logout'), () {
            AppProvider.getRouter(context).pop(context);
            _authBloc.add(LoggedOut());
          }),
          _getItem(
              10,
              Icons.help,
              AppLocalizations.of(context).tr('drawer.help.title'),
              AppLocalizations.of(context).tr('drawer.help.subtitle'),
              () {
              AppProvider.getRouter(context).pop(context);
              AppProvider.getRouter(context).navigateTo(context, HelpPage.PATH);
    }),
        ],
      ),
    );
  }

  Widget _getItem(int pos, final IconData icon, String title, String subtitle,
      GestureTapCallback callback) {
    return ListTile(
        selected: pos == selectedIndex,
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: callback);
  }

  void _logout() async {
    // ApiClient().logout().then((val) {
    //   if (val.isSuccessful()) {
    //     Prefs().clear().then((val) {
    //       widget._onLogout();
    //     });
    //   }
    // });
  }

  Widget _buildHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: _headerName(),
      accountEmail: _headerEmail(),
      currentAccountPicture: _headerProfileImage(),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _headerName() {
    return Text(
      user == null ? 'John Doe' : '${user.firstName} ${user.lastName}',
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _headerEmail() {
    return Text(
      user == null ? 'john.doe@flutter-plate.com' : '${user.email}',
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    );
  }

  Widget _headerProfileImage() {
    if (user == null)
      return CircleAvatar(
        backgroundImage:
            NetworkImage('https://randomuser.me/api/portraits/men/64.jpg'),
      );
    if (user.profileImageURL == null)
      return CircleAvatar(
        child: Text(
          user.firstName[0].toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    else
      return CircleAvatar(
        child: Image.network(user.profileImageURL),
      );
  }
}
