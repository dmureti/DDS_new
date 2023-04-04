import 'package:badges/badges.dart' as b;
import 'package:distributor/core/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionStatusWidget extends StatelessWidget {
  const ConnectionStatusWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.Offline) {
      return b.Badge(
        child: Icon(Icons.wifi),
        badgeColor: Colors.yellow,
      );
    } else {
      return Icon(
        Icons.wifi,
        color: Colors.white.withOpacity(0.2),
      );
    }
  }
}
