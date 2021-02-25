import 'package:distributor/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<String> getVersion;

  Future<List<String>> getChangeLog() async {
    try {
      String temp = await rootBundle.loadString('assets/docs/changelog.txt');
      List<String> exploded = temp.split("\r");
      return exploded;
    } catch (e) {
      return [e.toString()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerHeader(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    accountEmail: Text(
                      '${model.user.email}',
                      style: TextStyle(color: Colors.black),
                    ),
                    accountName: Text(
                      '${model.user.full_name}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            )),
            ListTile(
              trailing: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              trailing: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              trailing: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Log out'),
              onTap: () async {
                model.logout();
              },
            ),
            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(model.appEnv.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
