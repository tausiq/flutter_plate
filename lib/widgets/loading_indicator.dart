import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    decoration:
    BoxDecoration(color: Theme.of(context).colorScheme.onBackground),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

}
