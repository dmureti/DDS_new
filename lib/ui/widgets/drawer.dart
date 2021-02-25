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
            onTap: null,
            iconData: Icons.home,
          ),
          DrawerListTile(
            label: 'Journey',
            onTap: null,
            iconData: Icons.swap_calls,
          ),
          DrawerListTile(
            label: 'Stock Controller',
            onTap: null,
            iconData: Icons.apps,
          ),
          DrawerListTile(
            label: 'Sales',
            onTap: null,
            iconData: Icons.add_shopping_cart,
          ),
          DrawerListTile(
            label: 'Customers',
            onTap: null,
            iconData: Icons.people,
          ),
          ListTile(
            trailing: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {},
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
