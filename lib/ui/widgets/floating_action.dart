import 'package:flutter/material.dart';

class CustomFloatingAction extends StatelessWidget {
  final String tooltip;
  final Function onPressed;

  CustomFloatingAction({this.onPressed, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      isExtended: true,
      backgroundColor: Colors.pinkAccent,
      tooltip: 'Add a new customer',
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }
}
