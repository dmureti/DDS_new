import 'package:flutter/material.dart';

// If the user does not have permissions the button color with be lighter
BottomNavigationBarItem BottomNavBarButton(
    {int index, Function onTap, IconData iconData, bool isEnabled}) {
  return BottomNavigationBarItem(
    backgroundColor: Colors.indigo,
    icon: IconButton(
      splashColor: Colors.pink,
      icon: Icon(
        iconData,
      ),
      onPressed: () {
//          var result = model.onJourneyTabTap();
//          if (result is bool) {
//            if (result) {
//              model.updateIndex(1);
//              widget.onTap(Pages.routes, "Routes");
//            }
//          }
      },
    ),
    label: 'Journey'.toUpperCase(),
  );
}
