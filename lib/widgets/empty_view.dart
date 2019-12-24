import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String text;

  EmptyView(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text(text)));
  }
}
