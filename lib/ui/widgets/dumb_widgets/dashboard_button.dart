import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const DashboardButton({Key key, @required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 4.5;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: width,
        child: Card(
          shadowColor: Colors.black,
          child: Column(
            children: [
              Container(
                width: width,
                height: width * 0.6,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(fontFamily: 'ProximaNova700', fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
