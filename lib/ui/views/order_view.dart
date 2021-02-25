import 'package:distributor/core/models/order.dart';

import 'package:distributor/ui/widgets/drawer.dart';

import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  final Order order;
  OrderView({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
    );
  }
}
