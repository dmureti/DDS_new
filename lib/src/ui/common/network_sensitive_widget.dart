import 'package:distributor/core/enums.dart';
import 'package:distributor/ui/config/brand.dart';
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
        decoration: BoxDecoration(color: kColorfulMiniRed),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.white,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'You are offline. You will have limited functionality.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
