import 'package:distributor/src/ui/views/pos/checkout/checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckOutViewModel>.reactive(
        builder: (model, context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Checkout'),
            ),
          );
        },
        viewModelBuilder: () => CheckOutViewModel());
  }
}
