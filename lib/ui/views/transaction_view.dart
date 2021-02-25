import 'package:distributor/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatelessWidget {
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
