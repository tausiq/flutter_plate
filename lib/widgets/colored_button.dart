import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final String label;
  final Function callBack;

  ColoredButton(this.label, {this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: callBack,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
