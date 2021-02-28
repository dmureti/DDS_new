import 'package:distributor/ui/views/home/home_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/drawer_listTile.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class CustomDrawer extends HookViewModelWidget<HomeViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView(
        padding: EdgeInsets.zero,
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
          DrawerListTile(
            label: 'Home',
            onTap: () {
              Navigator.pop(context);
              model.navigateToHome(0);
            },
            iconData: Icons.home,
          ),
          DrawerListTile(
            label: 'Journey',
            onTap: () {
              Navigator.pop(context);
              model.navigateToHome(1);
            },
            iconData: Icons.swap_calls,
          ),
          DrawerListTile(
            label: 'Stock Controller',
            onTap: () {
              Navigator.pop(context);
              model.navigateToHome(2);
            },
            iconData: Icons.apps,
          ),
          DrawerListTile(
            label: 'Sales',
            onTap: () {
              Navigator.pop(context);
              model.navigateToHome(3);
            },
            iconData: Icons.add_shopping_cart,
          ),
          DrawerListTile(
            label: 'Customers',
            onTap: () {
              Navigator.pop(context);
              model.navigateToHome(4);
            },
            iconData: Icons.people,
          ),
          ListTile(
            trailing: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
              model.navigateToHome(5);
            },
          ),
          ListTile(
            title: Text('Log out'),
            onTap: () async {
              model.logout();
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.appEnv.name),
            ),
          ),
        ],
      ),
    );
  }
}
