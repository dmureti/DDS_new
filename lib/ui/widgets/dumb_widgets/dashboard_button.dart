import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const DashboardButton({Key key, @required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cellWidth = MediaQuery.of(context).size.width / 4;
    double appWidth = MediaQuery.of(context).size.width;
    if (appWidth > 600) {
      cellWidth = MediaQuery.of(context).size.width / 4.5;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth,
        height: cellWidth,
        child: Card(
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'ProximaNova500',
                    fontSize: 12,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
