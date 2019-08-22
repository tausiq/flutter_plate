import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/counter/counter_page.dart';
import 'package:flutter_plate/home/bloc/bloc.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/home/user.dart';
import 'package:easy_localization/easy_localization.dart';

class NavDrawer extends StatelessWidget {
  final User user;
  final int selectedIndex;

  NavDrawer(this.user, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);

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
              AppLocalizations.of(context).tr('drawer.home.subtitle'),
              _homeBloc.openHomePage),
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
              AppLocalizations.of(context).tr('drawer.counter.subtitle'),
              _homeBloc.openCounterPage),
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
          }),
          _getItem(
              5,
              Icons.new_releases,
              AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'), () {
            AppProvider.getRouter(context).pop(context);
          }),
          Divider(),
          _getItem(
              6,
              Icons.settings,
              AppLocalizations.of(context).tr('title_settings'),
              AppLocalizations.of(context).tr('subtitle_settings'), () {
            AppProvider.getRouter(context).pop(context);
          }),
          _getItem(
              7,
              Icons.exit_to_app,
              AppLocalizations.of(context).tr('title_logout'),
              AppLocalizations.of(context).tr('subtitle_logout'), () {
            AppProvider.getRouter(context).pop(context);
          }),
          _getItem(
              8,
              Icons.help,
              AppLocalizations.of(context).tr('title_about'),
              AppLocalizations.of(context).tr('subtitle_about'),
              () => {}),
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
