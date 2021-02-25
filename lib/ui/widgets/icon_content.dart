import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final int amount;
  final String title;

  IconContent({this.amount, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          amount.toString(),
          style: TextStyle(
            fontSize: 65.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 10),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
