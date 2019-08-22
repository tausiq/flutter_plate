import 'package:flutter/material.dart';
import 'package:flutter_plate/home/user.dart';
import 'package:easy_localization/easy_localization.dart';

class NavDrawer extends StatelessWidget {
  final User user;
  final int selectedIndex;

  NavDrawer(this.user, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildHeader(context),
          _getItem(0, Icons.home, AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'), () => {}),
          _getItem(1, Icons.category, AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'), () => {}),
          _getItem(2, Icons.fastfood, AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'), () => {}),
          _getItem(3, Icons.favorite, AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'), () => {}),
          _getItem(
              4,
              Icons.rate_review,
              AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'),
              () => {}),
          _getItem(
              5,
              Icons.new_releases,
              AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'),
              () => {}),
          Divider(),
          _getItem(6, Icons.settings, AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'), () => {}),
          _getItem(
              7,
              Icons.exit_to_app,
              AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'),
              () => {}),
          _getItem(
              8,
              Icons.info_outline,
              AppLocalizations.of(context).tr('title'),
              AppLocalizations.of(context).tr('title'),
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
      user == null ? 'john.doe@orderpi.com' : '${user.email}',
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
