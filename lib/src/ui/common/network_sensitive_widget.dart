import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/widgets/smart_widgets/syncWidget/syncWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkSensitiveWidget extends StatelessWidget {
  const NetworkSensitiveWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the connection status
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.Offline) {
      return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Connection',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return SyncWidget();
    }
  }
}
