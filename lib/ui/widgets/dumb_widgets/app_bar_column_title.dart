import 'package:flutter/material.dart';

class AppBarColumnTitle extends StatelessWidget {
  final String mainTitle;
  final String subTitle;

  const AppBarColumnTitle({Key key, this.mainTitle, this.subTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(mainTitle),
        SizedBox(
          height: 4,
        ),
        Text(
          subTitle,
          style: TextStyle(fontSize: 14),
        ),
      ],
    ));
  }
}
