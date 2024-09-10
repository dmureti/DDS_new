import 'package:flutter/material.dart';

class GenericContainer extends StatelessWidget {
  final Widget child;
  const GenericContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }
}
