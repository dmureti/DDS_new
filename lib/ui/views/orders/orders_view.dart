import 'package:distributor/ui/views/orders/orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrdersViewModel>.reactive(
        builder: (context, model, child) => Scaffold(),
        viewModelBuilder: () => OrdersViewModel());
  }
}
