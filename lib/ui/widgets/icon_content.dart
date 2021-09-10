import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final int amount;
  final String title;
  IconContent({this.amount, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        amount == null
            ? Container(
                child: Center(child: CircularProgressIndicator()),
                height: 65,
              )
            : Text(
                amount.toString(),
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 10),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
