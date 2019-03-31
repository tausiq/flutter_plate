import 'package:flutter/material.dart';

class DialogUtils {
  static void showSnackBar(GlobalKey<ScaffoldState> key, String txt) {
    key.currentState.showSnackBar(SnackBar(content: Text(txt)));
  }

  static void showProgressSnackBar(GlobalKey<ScaffoldState> key, String txt) {
    key.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 20),
      content: Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          SizedBox(
            width: 16.0,
          ),
          Text(txt)
        ],
      ),
    ));
  }

  static void hideSnackBar(GlobalKey<ScaffoldState> key) {
    key.currentState.hideCurrentSnackBar();
  }

//  void showDialog(BuildContext context) {
//    showDialog(
//        context: context,
//        builder: (_) => new AlertDialog(
//      title: new Text("Add Prize Bond"),
//      content: new TextFormField(
//        keyboardType: TextInputType.number,
//        decoration: const InputDecoration(
//          border: const OutlineInputBorder(),
//          labelText: 'Enter prize bond number',
//        ),
//        maxLines: 1,
//        maxLength: 7,
//        controller: myController,
//
//      ),
//      actions: <Widget>[
//        new FlatButton(
//          child: new Text("Cancel"),
//          onPressed: () => Navigator.pop(context),
//        ),
//        new FlatButton(
//            child: new Text("Add"),
//            onPressed: () {
//              inputId = myController.text;
//              myController.clear();
////                              _addNewPrizeBondNumber();
//              Navigator.pop(context);
//            })
//      ],
//    ),);
//  }

  static void confirmDialog(BuildContext context, String title, String content,
      VoidCallback callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  callback();
                },
              ),
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
