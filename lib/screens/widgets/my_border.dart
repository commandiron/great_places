import 'package:flutter/material.dart';


class MyBorder extends StatelessWidget {

  final Widget child;

  MyBorder({this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.red,
            width: 2
        )
      ),
      child: child,
    );
  }
}
