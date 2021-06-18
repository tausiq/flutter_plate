import 'dart:ui';

import 'package:flutter/material.dart';

import 'notification.dart';

class SocialNotificationPage extends StatefulWidget {
  @override
  _SocialNotificationPageState createState() => _SocialNotificationPageState();
}

class _SocialNotificationPageState extends State<SocialNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363846),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
            child: Text(
              'Notification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.all(10),
              separatorBuilder: (BuildContext context, int index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 0.5,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Divider(),
                  ),
                );
              },
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                Map notif = notifications[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        notif['dp'],
                      ),
                      radius: 25,
                    ),

                    contentPadding: EdgeInsets.all(0),
                    title: Text(notif['notif'], style: TextStyle(color: Colors.white),),
                    trailing: Text(
                      notif['time'],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    onTap: (){},
                  ),
                );
              },

            ),
          ),
        ],
      ),
    );

  }
}
