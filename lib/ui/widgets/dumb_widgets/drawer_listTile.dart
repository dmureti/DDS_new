import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String label;
  final Function onTap;
  final IconData iconData;

  const DrawerListTile({Key key, this.label, this.onTap, this.iconData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: () {
        onTap();
      },
      trailing: Icon(iconData),
    );
  }
}
