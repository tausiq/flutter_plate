import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/app/ui/app_store_page.dart';
import 'package:flutter_plate/auth/bloc/auth_bloc.dart';
import 'package:flutter_plate/auth/bloc/auth_event.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/counter/counter_page.dart';
import 'package:flutter_plate/help/help_page.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/post/ui/post_page.dart';
import 'package:flutter_plate/settings/settings_page.dart';
import 'package:flutter_plate/social/social_page.dart';
import 'package:flutter_plate/timer/timer_page.dart';
import 'package:flutter_plate/todo/todo_page.dart';
import 'package:flutter_plate/user/app_user.dart';
import 'package:flutter_plate/user/users_page.dart';
import 'package:flutter_plate/workout/workout_page.dart';

class NavDrawer extends StatelessWidget {
  final AppUser user;
  final int selectedIndex;

  NavDrawer(this.user, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    // final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    //ignore: close_sinks
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildHeader(context),
          _getItem(0, Icons.home, tr('drawer.home.title'), tr('drawer.home.subtitle'),
              () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, HomePage.PATH);
          }),
          _getItem(1, Icons.category, tr('drawer.app_store.title'),
              tr('drawer.app_store.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, AppStorePage.PATH);
          }),
          _getItem(2, Icons.fastfood, tr('drawer.counter.title'),
              tr('drawer.counter.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, CounterPage.PATH);
          }),
          _getItem(3, Icons.favorite, tr('drawer.post.title'), tr('drawer.post.subtitle'),
              () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, PostPage.PATH);
          }),
          _getItem(
              4, Icons.rate_review, tr('drawer.timer.title'), tr('drawer.timer.subtitle'),
              () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, TimerPage.PATH);
          }),
          _getItem(5, Icons.work, tr('drawer.todo.title'), tr('drawer.todo.subtitle'),
              () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, TodoPage.PATH);
          }),
          _getItem(6, Icons.airline_seat_recline_extra, tr('drawer.workout.title'),
              tr('drawer.workout.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, WorkoutPage.PATH);
          }),
          _getItem(7, Icons.group, tr('drawer.users.title'), tr('drawer.users.subtitle'),
              () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, UsersPage.PATH);
          }),
          _getItem(8, Icons.group_work, tr('drawer.social.title'),
              tr('drawer.social.subtitle'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, SocialPage.PATH);
          }),
          Divider(),
          _getItem(9, Icons.settings, tr('title_settings'), tr('subtitle_settings'), () {
            AppProvider.getRouter(context).pop(context);
            AppProvider.getRouter(context).navigateTo(context, SettingsPage.PATH);
          }),
          _getItem(10, Icons.exit_to_app, tr('title_logout'), tr('subtitle_logout'), () {
            AppProvider.getRouter(context).pop(context);
            _authBloc.add(LoggedOut());
          }),
          _getItem(11, Icons.help, tr('drawer.help.title'), tr('drawer.help.subtitle'),
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
    if (user == null || user.firstName.isEmpty)
      return CircleAvatar(
        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/64.jpg'),
      );
    else if (user.profileImageURL == null)
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
