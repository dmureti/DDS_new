import 'package:flutter/material.dart';

class DrawerSecondaryButton extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final Color color;
  const DrawerSecondaryButton(
      {Key key, this.iconData, this.onTap, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            color: color,
            size: 30,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
