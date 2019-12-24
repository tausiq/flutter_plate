import 'package:flutter/material.dart';
import 'package:flutter_plate/user/user.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/settings/prefs_const.dart';
import 'package:preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  static const String PATH = '/settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    User user = AppProvider.getApplication(context).loggedInUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: PreferencePage([
        PreferenceTitle('Profile'),
        PreferenceText(
          'Name: ' + user.firstName + " " + user.lastName,
          style: TextStyle(color: Colors.grey),
        ),
        PreferenceText(
          'Email: ' + user.email,
          style: TextStyle(color: Colors.grey),
        ),
        PreferenceTitle('Configuration'),
        PreferenceDialogLink(
          'Daily Workout',
          dialog: PreferenceDialog(
            [
              TextFieldPreference(
                'Enter Workout Minute',
                WORKOUT_MIN_PER_DAY,
                padding: const EdgeInsets.only(top: 8.0),
                autofocus: true,
                maxLines: 1,
              )
            ],
            title: 'Workout Minute',
            cancelText: 'Cancel',
            submitText: 'Save',
            onlySaveOnSubmit: true,
          ),
        ),
      ]),
    );
  }
}
