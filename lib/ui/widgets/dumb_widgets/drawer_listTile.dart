import 'package:distributor/conf/dds_brand_guide.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String label;
  final Function onTap;
  final IconData iconData;
  final bool enabled;

  const DrawerListTile(
      {Key key, this.label, this.onTap, this.iconData, bool isEnabled})
      : enabled = isEnabled ?? false,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text(
        label.toUpperCase(),
        style: TextStyle(fontFamily: 'NerisBlack', color: kColDDSPrimaryDark),
      ),
      onTap: () {
        onTap();
      },
      trailing: Icon(
        iconData,
        color: kColDDSPrimaryDark,
      ),
    );
  }
}
