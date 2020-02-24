import 'dart:math';

import 'package:flutter/material.dart';

import 'notification.dart';

class SocialProfilePage extends StatefulWidget {
  @override
  _SocialProfilePageState createState() => _SocialProfilePageState();
}

class _SocialProfilePageState extends State<SocialProfilePage> {
  static Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363846),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 40),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/women/${random.nextInt(10)}.jpg",
                ),
                radius: 50,
              ),
              SizedBox(height: 10),
              Text(
                names[random.nextInt(10)],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3),

              Text(
                "Status should be here",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    color: Colors.grey,
                    onPressed: (){},
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: (){},
                  ),

                ],
              ),

              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          random.nextInt(10000).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Posts",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: <Widget>[
                        Text(
                          random.nextInt(10000).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Friends",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: <Widget>[
                        Text(
                          random.nextInt(10000).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Groups",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                padding: EdgeInsets.all(5),
                itemCount: 15,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 200 / 200,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Image.network(
                      "https://randomuser.me/api/portraits/women/${random.nextInt(20)}.jpg",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
