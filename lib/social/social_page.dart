import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/social/social_home_page.dart';
import 'package:flutter_plate/social/social_notification_page.dart';
import 'package:flutter_plate/social/social_profile_page.dart';
import 'package:flutter_plate/social/social_settings_page.dart';
import 'package:flutter_plate/widgets/icon_badge.dart';

import 'social_chats_page.dart';

class SocialPage extends StatefulWidget {
  static const String PATH = '/social';
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D3F4B),
      body: SafeArea(
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              SocialHomePage(),
              SocialChatPage(),
              SocialNotificationPage(),
              SocialProfilePage(),
              SocialSettingsPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xFF3D3F4B),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              title: Text('Chat'),
              icon: Icon(Icons.chat_bubble)
          ),
          BottomNavyBarItem(
            title: Text('Notifiation'),
            icon: Icon(Icons.notifications)
          ),
          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.people)
          ),
          BottomNavyBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings)
          ),
        ],
      ),
    );
  }
}