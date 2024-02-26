import 'package:distributor/src/ui/views/pos/sales_returns/sales_returns_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SalesReturnsView extends StatelessWidget {
  const SalesReturnsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesReturnsViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Sales Returns'),
            ),
          );
        },
        viewModelBuilder: () => SalesReturnsViewModel());
  }
}
