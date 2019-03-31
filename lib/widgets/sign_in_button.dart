import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String title;
  final String uri;
  final Color color;

  SignInButton(this.title, this.uri,
      [this.color = const Color.fromRGBO(68, 68, 76, .8)]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 48.0,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              uri,
              width: 24.0,
            ),
            Padding(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: color,
                ),
              ),
              padding: new EdgeInsets.only(left: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
