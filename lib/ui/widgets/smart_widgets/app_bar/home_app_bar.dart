import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  const HomeAppBar({this.title, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsIconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.refresh),
        ),
        IconButton(
          onPressed: null,
          icon: badge.Badge(
            padding: EdgeInsets.all(3.0),
            position: badge.BadgePosition(top: -2, end: -2),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
